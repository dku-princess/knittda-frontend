import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_add_button.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_dropdown.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_field.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_form_section.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_form_text_styles.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_input.dart';
import 'package:knittda/src/presentation/widgets/knittda_snack_bar.dart';
import 'package:knittda/src/presentation/widgets/knittda_app_bar.dart';
import 'package:knittda/src/presentation/widgets/knittda_loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/domain/model/default_thumbnail.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_event.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_ui_event.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_view_model.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/core/theme/theme.dart';

enum _ThumbnailSource { galleryImage, defaultImage }

// 서버 값(value)과 화면 문구(label).
// TODO(api): 상태 저장은 API 연동 단계에서 반영
enum _ProjectStatus {
  inProgress('IN_PROGRESS', '뜨고 있어요'),
  done('DONE', '다 떴어요');

  const _ProjectStatus(this.value, this.label);

  final String value;
  final String label;
}

class AddEditProjectScreen extends StatefulWidget {
  final Project? project;

  const AddEditProjectScreen({super.key, this.project});

  @override
  State<AddEditProjectScreen> createState() => _AddEditProjectScreenState();
}

class _AddEditProjectScreenState extends State<AddEditProjectScreen> {
  // 상수
  static const _shortFieldMaxLength = 30;
  static const _infoFieldMaxLength = 100;
  static const double _thumbnailBoxSize = 100;
  static const double _screenPaddingH = AppSpacing.space16;
  static const double _screenPaddingTop = AppSpacing.space16;
  static const double _listGap = AppSpacing.space8;

  // 입력값
  final _nicknameController = TextEditingController();
  final _designTitleController = TextEditingController();
  final _designerController = TextEditingController();
  final _needleInfoController = TextEditingController();
  // 실 한 개당 컨트롤러 하나. 행을 추가,삭제할 때 함께 만들고 정리한다.
  final List<TextEditingController> _yarnControllers = [];

  DateTime? _goalDate;
  DateTime? _startDate;
  _ProjectStatus? _status;

  // 썸네일
  final ImagePicker _picker = ImagePicker();

  // _thumbnailUrl: 작품 썸네일. 수정 화면 진입 시 서버의 기존 값으로 채워짐.
  // _galleryImage: 갤러리 이미지. 이번 세션에 갤러리에서 새로 고른 로컬 파일.
  // _defaultThumbnailId: 기본 이미지. 서버 기본 이미지 목록 중 고른 항목 id.
  String? _thumbnailUrl;
  XFile? _galleryImage;
  int? _defaultThumbnailId;

  // 갤러리 이미지와 기본 이미지 중 어디에 포커싱 되어있는지
  // null: 아직 선택 안 함 (수정 화면이면 기존 썸네일인 _thumbnailUrl 기준으로 표시)
  _ThumbnailSource? _focusedSource;

  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    final project = widget.project;
    if (project != null) {
      _nicknameController.text = project.nickname;
      _designTitleController.text = project.design?.title ?? '';
      _designerController.text = project.design?.designer ?? '';
      _needleInfoController.text = project.design?.needleInfo ?? '';

      // TODO: v2로 실 목록을 채운다. 지금은 v1 문자열을 한 줄로 넣는다.
      final yarnInfo = project.design?.yarnInfo ?? '';
      if (yarnInfo.isNotEmpty) {
        _yarnControllers.add(TextEditingController(text: yarnInfo));
      }

      _startDate = DateTime.tryParse(project.startDate);
      _goalDate = DateTime.tryParse(project.goalDate);

      if (project.thumbnailUrl?.isNotEmpty ?? false) {
        _thumbnailUrl = project.thumbnailUrl;
      }

      _status = _ProjectStatus.values
          .where((s) => s.value == project.status)
          .firstOrNull;
    }

    Future.microtask(() {
      if (mounted) {
        final viewModel = context.read<AddEditProjectViewModel>();

        _subscription = viewModel.eventStream.listen((event) {
          if (mounted) {
            switch (event) {
              case SavedProject(:final project):
                Navigator.pop(context, project);
              case ShowSnackBar(:final message):
                KnittdaSnackBar.show(context, message);
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _designTitleController.dispose();
    _designerController.dispose();
    _needleInfoController.dispose();
    for (final controller in _yarnControllers) {
      controller.dispose();
    }
    _subscription?.cancel();
    super.dispose();
  }

  // 갤러리에서 사진을 선택 -> 갤러리 이미지를 포커싱 상태로 전환
  Future<void> _pickGalleryImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 70,
    );

    if (!mounted) return;

    if (picked != null) {
      setState(() {
        _galleryImage = picked;
        _focusedSource = _ThumbnailSource.galleryImage;
      });
    }
  }

  // 반투명한 gallery-box를 탭 -> 갤러리 이미지를 다시 포커싱 상태로 전환
  void _focusGalleryImage() {
    setState(() {
      _focusedSource = _ThumbnailSource.galleryImage;
    });
  }

  // gallery-box의 X 버튼 -> 갤러리 이미지 초기화
  // 갤러리 이미지가 포커싱 상태였다면 기본 이미지 선택까지 초기화 (처음 상태로)
  void _clearGalleryImage() {
    setState(() {
      _galleryImage = null;
      _thumbnailUrl = null;
      if (_focusedSource == _ThumbnailSource.galleryImage) {
        _focusedSource = null;
        _defaultThumbnailId = null;
      }
    });
  }

  // 기본 이미지를 선택 -> 기본 이미지를 포커싱 상태로 전환
  void _selectDefaultThumbnail(DefaultThumbnail thumbnail) {
    setState(() {
      _defaultThumbnailId = thumbnail.id;
      _focusedSource = _ThumbnailSource.defaultImage;
    });
  }

  DefaultThumbnail? _findDefaultThumbnailByUrl(
    List<DefaultThumbnail> defaultThumbnails,
    String url,
  ) {
    for (final thumbnail in defaultThumbnails) {
      if (thumbnail.imageUrl == url) return thumbnail;
    }
    return null;
  }

  // isSelected 이미지 선택 여부, isFocused 포커싱 여부
  // isSelected=false & isFocused=false → 회색 + 박스
  // isSelected=true  & isFocused=true  → 갤러리 이미지
  // isSelected=true  & isFocused=false → 갤러리 이미지 반투명
  Widget _buildGalleryBox({
    required bool isSelected,
    required bool isFocused,
    required bool showExistingUrl,
  }) {
    final Widget content;
    if (_galleryImage != null) {
      content = Image.file(
        File(_galleryImage!.path),
        width: _thumbnailBoxSize,
        height: _thumbnailBoxSize,
        fit: BoxFit.cover,
      );
    } else if (showExistingUrl && (_thumbnailUrl?.isNotEmpty ?? false)) {
      content = Image.network(
        _thumbnailUrl!,
        width: _thumbnailBoxSize,
        height: _thumbnailBoxSize,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: _thumbnailBoxSize,
          height: _thumbnailBoxSize,
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      );
    } else {
      content = Container(
        width: _thumbnailBoxSize,
        height: _thumbnailBoxSize,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Icon(Icons.add, color: Colors.white, size: 40),
        ),
      );
    }

    final onTap = isSelected && !isFocused
        ? _focusGalleryImage
        : _pickGalleryImage;

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isSelected && !isFocused ? 0.4 : 1.0,
        child: Stack(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(10), child: content),
            if (isSelected)
              Positioned(
                top: 2,
                right: 2,
                child: GestureDetector(
                  onTap: _clearGalleryImage,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.close,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultThumbnailTile(
    DefaultThumbnail thumbnail, {
    required bool dim,
  }) {
    return GestureDetector(
      onTap: () => _selectDefaultThumbnail(thumbnail),
      child: Opacity(
        opacity: dim ? 0.4 : 1.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            thumbnail.imageUrl,
            width: _thumbnailBoxSize,
            height: _thumbnailBoxSize,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: _thumbnailBoxSize,
              height: _thumbnailBoxSize,
              color: Colors.grey[200],
              child: const Icon(Icons.broken_image, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnailList(List<DefaultThumbnail> defaultThumbnails) {
    // 기존 썸네일이 기본 이미지 중 하나와 URL이 일치하는지 확인
    // 일치하고 아직 다른 선택이 없으면(_focusedSource == null) 해당 기본 이미지를 포커싱
    final matchedExistingDefault = (_thumbnailUrl?.isNotEmpty ?? false)
        ? _findDefaultThumbnailByUrl(defaultThumbnails, _thumbnailUrl!)
        : null;

    final effectiveDefaultThumbnailId = switch (_focusedSource) {
      _ThumbnailSource.defaultImage => _defaultThumbnailId,
      _ThumbnailSource.galleryImage => null,
      null => matchedExistingDefault?.id,
    };

    final galleryIsSelected =
        _galleryImage != null ||
        (matchedExistingDefault == null &&
            (_thumbnailUrl?.isNotEmpty ?? false));

    final galleryIsFocused =
        _focusedSource == _ThumbnailSource.galleryImage ||
        (_focusedSource == null &&
            matchedExistingDefault == null &&
            galleryIsSelected);

    final hasAnySelection =
        galleryIsFocused || effectiveDefaultThumbnailId != null;

    return SizedBox(
      height: _thumbnailBoxSize,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildGalleryBox(
              isSelected: galleryIsSelected,
              isFocused: galleryIsFocused,
              showExistingUrl: matchedExistingDefault == null,
            ),
            for (final thumbnail in defaultThumbnails) ...[
              SizedBox(width: 10),
              _buildDefaultThumbnailTile(
                thumbnail,
                dim:
                    hasAnySelection &&
                    thumbnail.id != effectiveDefaultThumbnailId,
              ),
            ],
          ],
        ),
      ),
    );
  }

  // 시작일이 목표일보다 늦어지지 않게 선택 범위로 막는다.
  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? _goalDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: _goalDate ?? DateTime(2100),
    );
    if (!mounted || picked == null) return;
    setState(() => _startDate = picked);
  }

  Future<void> _pickGoalDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _goalDate ?? _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (!mounted || picked == null) return;
    setState(() => _goalDate = picked);
  }

  String? _formatDate(DateTime? date) =>
      date == null ? null : DateUtilsHelper.toSpacedDotFormat(date);

  Widget _buildYarnSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: _listGap,
      children: [
        Text('실', style: ProjectFormTextStyles.label),
        for (final controller in _yarnControllers)
          ProjectInput.text(
            key: ObjectKey(controller),
            controller: controller,
            placeholder: '실을 입력해주세요',
            maxLength: _infoFieldMaxLength,
            onMaxLengthExceeded: () => _showMaxLengthSnack(_infoFieldMaxLength),
            onRemove: () => _removeYarn(controller),
          ),
        ProjectAddButton(label: '실 추가', onPressed: _addYarn),
      ],
    );
  }

  void _addYarn() {
    setState(() => _yarnControllers.add(TextEditingController()));
  }

  void _removeYarn(TextEditingController controller) {
    setState(() => _yarnControllers.remove(controller));
    // 지운 행의 입력칸이 화면에서 빠진 뒤에 정리해야 오류가 나지 않는다.
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.dispose());
  }

  // 한도 초과 상태에서 키 연타/붙여넣기로 onMaxLengthExceeded가 연속 호출돼도,
  // KnittdaSnackBar.show가 매번 hideCurrentSnackBar() 후 showSnackBar()를 호출하므로
  // 스낵바가 큐에 쌓이지는 않는다(계속 같은 스낵바로 즉시 교체됨).
  void _showMaxLengthSnack(int maxLength) {
    KnittdaSnackBar.show(
      context,
      '최대 $maxLength자까지 입력할 수 있어요.',
      tone: KnittdaSnackTone.error,
    );
  }

  Future<void> _saveProject() async {
    final viewModel = context.read<AddEditProjectViewModel>();

    final nickname = _nicknameController.text.trim();
    // TODO: v2로 바꾸면 yarns 목록으로 보낸다.
    final customYarnInfo = _yarnControllers
        .map((controller) => controller.text.trim())
        .where((name) => name.isNotEmpty)
        .join(', ');
    final customNeedleInfo = _needleInfoController.text.trim();
    final designTitle = _designTitleController.text.trim();
    final designer = _designerController.text.trim();

    final hasImage =
        _focusedSource != null || (_thumbnailUrl?.isNotEmpty ?? false);

    if (!hasImage) {
      KnittdaSnackBar.show(
        context,
        '대표 사진을 추가해주세요.',
        tone: KnittdaSnackTone.error,
      );
      return;
    }
    if (nickname.isEmpty) {
      KnittdaSnackBar.show(
        context,
        '작품 이름을 입력해주세요.',
        tone: KnittdaSnackTone.error,
      );
      return;
    }
    if (_startDate == null || _goalDate == null) {
      KnittdaSnackBar.show(
        context,
        '시작일과 목표일을 선택해주세요.',
        tone: KnittdaSnackTone.error,
      );
      return;
    }

    final file = _focusedSource == _ThumbnailSource.galleryImage
        ? _galleryImage
        : null;
    final defaultThumbnailId = _focusedSource == _ThumbnailSource.defaultImage
        ? _defaultThumbnailId
        : null;

    if (widget.project == null) {
      viewModel.onEvent(
        AddEditProjectEvent.saveProject(
          project: Project(
            nickname: nickname,
            startDate: DateUtilsHelper.toHyphenFormat(_startDate!),
            goalDate: DateUtilsHelper.toHyphenFormat(_goalDate!),
            needleInfo: customNeedleInfo,
            yarnInfo: customYarnInfo,
            designTitle: designTitle,
            designer: designer,
            visible: false,
          ),
          file: file,
          defaultThumbnailId: defaultThumbnailId,
        ),
      );
    } else {
      viewModel.onEvent(
        AddEditProjectEvent.saveProject(
          project: widget.project!.copyWith(
            projectId: widget.project!.id,
            nickname: nickname,
            startDate: DateUtilsHelper.toHyphenFormat(_startDate!),
            goalDate: DateUtilsHelper.toHyphenFormat(_goalDate!),
            needleInfo: customNeedleInfo,
            yarnInfo: customYarnInfo,
            designTitle: designTitle,
            designer: designer,
          ),
          file: file,
          defaultThumbnailId: defaultThumbnailId,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddEditProjectViewModel>();

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.grey50,
          appBar: KnittdaAppBar(
            title: widget.project != null ? '작품 수정' : '작품 추가',
            centerTitle: true,
            actions: [
              // KnittdaButton은 글자 크기·색이 고정이라 로컬로 둔다.
              TextButton(
                onPressed: viewModel.state.isLoading ? null : _saveProject,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  disabledForegroundColor: AppColors.textHint,
                  textStyle: ProjectFormTextStyles.label,
                ),
                child: const Text('저장'),
              ),
              const SizedBox(width: AppSpacing.space8),
            ],
          ),

          body: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

            padding: const EdgeInsets.fromLTRB(
              _screenPaddingH,
              _screenPaddingTop,
              _screenPaddingH,
              AppLayout.contentBottomInset,
            ),

            children: [
              _buildThumbnailList(viewModel.state.defaultThumbnails),
              const SizedBox(height: AppSpacing.space16),

              ProjectFormSection(
                title: '기본 정보',
                children: [
                  ProjectField(
                    label: '작품명',
                    child: ProjectInput.text(
                      controller: _nicknameController,
                      placeholder: '작품명을 입력해주세요',
                      maxLength: _shortFieldMaxLength,
                      onMaxLengthExceeded: () =>
                          _showMaxLengthSnack(_shortFieldMaxLength),
                    ),
                  ),
                  ProjectField(
                    label: '시작일',
                    child: ProjectInput.date(
                      value: _formatDate(_startDate),
                      placeholder: '날짜를 선택해주세요',
                      onTap: _pickStartDate,
                    ),
                  ),
                  ProjectField(
                    label: '목표일',
                    child: ProjectInput.date(
                      value: _formatDate(_goalDate),
                      placeholder: '날짜를 선택해주세요',
                      onTap: _pickGoalDate,
                    ),
                  ),
                  ProjectField(
                    label: '상태',
                    child: ProjectDropdown<_ProjectStatus>(
                      options: _ProjectStatus.values,
                      value: _status,
                      labelOf: (s) => s.label,
                      placeholder: '선택해주세요',
                      onChanged: (s) => setState(() => _status = s),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.space16),

              ProjectFormSection(
                title: '디자인',
                children: [
                  ProjectField(
                    label: '도안',
                    child: ProjectInput.text(
                      controller: _designTitleController,
                      placeholder: '도안을 입력해주세요',
                      maxLength: _shortFieldMaxLength,
                      onMaxLengthExceeded: () =>
                          _showMaxLengthSnack(_shortFieldMaxLength),
                    ),
                  ),
                  ProjectField(
                    label: '작가',
                    child: ProjectInput.text(
                      controller: _designerController,
                      placeholder: '작가를 입력해주세요',
                      maxLength: _shortFieldMaxLength,
                      onMaxLengthExceeded: () =>
                          _showMaxLengthSnack(_shortFieldMaxLength),
                    ),
                  ),
                  _buildYarnSection(),
                  // TODO: 바늘 목록으로 교체
                  Text('바늘', style: ProjectFormTextStyles.label),
                  ProjectInput.text(
                    controller: _needleInfoController,
                    maxLength: _infoFieldMaxLength,
                    onMaxLengthExceeded: () =>
                        _showMaxLengthSnack(_infoFieldMaxLength),
                  ),
                ],
              ),
            ],
          ),
        ),

        if (viewModel.state.isLoading)
          const Positioned.fill(child: KnittdaLoadingOverlay()),
      ],
    );
  }
}
