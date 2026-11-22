import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:knittda/src/domain/model/design.dart';
import 'package:knittda/src/domain/model/needle.dart';
import 'package:knittda/src/domain/model/yarn.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_add_button.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_dropdown.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_field.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_form_section.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_form_text_styles.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_input.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_needle_row.dart';
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
  static const Duration _scrollDuration = Duration(milliseconds: 300);

  // 입력값
  final _nicknameController = TextEditingController();
  final _designTitleController = TextEditingController();
  final _designerController = TextEditingController();
  // 실 한 개당 컨트롤러 하나. 행을 추가·삭제할 때 함께 만들고 정리한다.
  final List<TextEditingController> _yarnControllers = [];
  final List<_NeedleRowData> _needles = [];

  // 서버가 해석하지 못한 기존 바늘 원문.
  final List<String> _needleRawTexts = [];

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
      _initYarnAndNeedleRows(project.design);

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
    for (final controller in _yarnControllers) {
      controller.dispose();
    }
    for (final needle in _needles) {
      needle.dispose();
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

  Widget _buildYarnList() {
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

  Widget _buildNeedleList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: _listGap,
      children: [
        Text('바늘', style: ProjectFormTextStyles.label),
        if (_needleRawTexts.isNotEmpty)
          Text(
            '기존 입력: ${_needleRawTexts.join(', ')} · 다시 입력해 주세요',
            style: AppTextStyles.body.copyWith(color: AppColors.textHint),
          ),
        for (final needle in _needles)
          ProjectNeedleRow(
            key: needle.key,
            type: needle.type,
            onTypeChanged: (type) => setState(() {
              needle.type = type;
              needle.error = null;
            }),
            sizeController: needle.sizeController,
            onSizeChanged: (_) {
              if (needle.error != null) setState(() => needle.error = null);
            },
            unit: needle.unit,
            onUnitChanged: (unit) => setState(() => needle.unit = unit),
            onRemove: () => _removeNeedle(needle),
            error: needle.error,
          ),
        ProjectAddButton(label: '바늘 추가', onPressed: _addNeedle),
      ],
    );
  }

  // 작품의 실·바늘 목록으로 입력 행을 만든다.
  // 해석하지 못한 기존 바늘(rawText)은 입력 행 대신 안내 문구로 보여준다.
  void _initYarnAndNeedleRows(Design? design) {
    for (final yarn in design?.yarns ?? const <Yarn>[]) {
      _yarnControllers.add(TextEditingController(text: yarn.name));
    }
    for (final needle in design?.needles ?? const <Needle>[]) {
      final rawText = needle.rawText;
      if (rawText != null) {
        _needleRawTexts.add(rawText);
      } else {
        _needles.add(_NeedleRowData.fromNeedle(needle));
      }
    }
  }

  void _addYarn() {
    setState(() => _yarnControllers.add(TextEditingController()));
  }

  void _removeYarn(TextEditingController controller) {
    setState(() => _yarnControllers.remove(controller));
    // 지운 행의 입력칸이 화면에서 빠진 뒤에 정리해야 오류가 나지 않는다.
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.dispose());
  }

  void _addNeedle() {
    setState(() => _needles.add(_NeedleRowData()));
  }

  void _removeNeedle(_NeedleRowData needle) {
    setState(() => _needles.remove(needle));
    // 지운 행의 입력칸이 화면에서 빠진 뒤에 정리해야 오류가 나지 않는다.
    WidgetsBinding.instance.addPostFrameCallback((_) => needle.dispose());
  }

  // 바늘 행을 모두 검사해 에러를 표시하고, 첫 에러 행을 화면 가운데로 스크롤한다.
  bool _validateNeedles() {
    setState(() {
      for (final needle in _needles) {
        needle.error = needle.validate();
      }
    });

    final firstError = _needles.where((n) => n.error != null).firstOrNull;
    if (firstError == null) return true;

    // 에러 문구가 그려진 뒤에 위치를 재야 문구까지 화면에 들어온다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final rowContext = firstError.key.currentContext;
      if (rowContext == null) return;
      Scrollable.ensureVisible(
        rowContext,
        duration: _scrollDuration,
        alignment: 0.5,
      );
    });
    return false;
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
    // 빈 행은 빼고, 화면에 있는 목록 전체를 보낸다.
    final yarns = _yarnControllers
        .map((controller) => controller.text.trim())
        .where((name) => name.isNotEmpty)
        .map((name) => Yarn(name: name))
        .toList();
    final needles = _needles
        .where((needle) => !needle.isEmpty)
        .map((needle) => needle.toNeedle())
        .toList();
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
    if (!_validateNeedles()) return;

    final file = _focusedSource == _ThumbnailSource.galleryImage
        ? _galleryImage
        : null;
    final defaultThumbnailId = _focusedSource == _ThumbnailSource.defaultImage
        ? _defaultThumbnailId
        : null;

    // 상태를 고르지 않았으면 기존 상태와 종료일을 그대로 둔다.
    final status = _status?.value ?? widget.project?.status;
    final endDate = switch (_status) {
      null => widget.project?.endDate,
      // 다 떴어요(DONE): 기존 종료일이 있으면 그대로 두고, 없으면 오늘 날짜로 저장한다.
      _ProjectStatus.done =>
        widget.project?.endDate ??
            DateUtilsHelper.toHyphenFormat(DateTime.now()),
      _ProjectStatus.inProgress => null,
    };

    if (widget.project == null) {
      viewModel.onEvent(
        AddEditProjectEvent.saveProject(
          project: Project(
            nickname: nickname,
            startDate: DateUtilsHelper.toHyphenFormat(_startDate!),
            goalDate: DateUtilsHelper.toHyphenFormat(_goalDate!),
            endDate: endDate,
            status: status,
            yarns: yarns,
            needles: needles,
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
            endDate: endDate,
            status: status,
            yarns: yarns,
            needles: needles,
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
                  _buildYarnList(),
                  _buildNeedleList(),
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

/// 화면에서 편집 중인 바늘 한 줄. 새 행은 종류 미선택 | 굵기 빈칸 | mm로 시작한다.
class _NeedleRowData {
  _NeedleRowData() : unit = NeedleSizeUnit.mm;

  /// 받은 바늘로 행을 만든다. 단위가 비어 있으면 mm로 둔다.
  _NeedleRowData.fromNeedle(Needle needle)
    : type = needle.type,
      unit = needle.unit ?? NeedleSizeUnit.mm {
    sizeController.text = needle.valueText ?? '';
  }

  NeedleType? type;
  NeedleSizeUnit unit;
  final sizeController = TextEditingController();

  /// 첫 에러 행으로 스크롤할 때 행 위치를 찾는다.
  final key = GlobalKey();

  /// 저장할 때 검사한 에러. 칸을 고치면 지운다.
  NeedleRowError? error;

  // 0 이상 9999.99 이하, 소수 둘째 자리까지.
  static final _sizePattern = RegExp(r'^\d{1,4}(\.\d{1,2})?$');

  String get _sizeText => sizeController.text.trim();

  /// 종류와 굵기가 모두 비어 있는 행. 저장할 때 뺀다.
  bool get isEmpty => type == null && _sizeText.isEmpty;

  /// 행 에러. 빈 행은 검사하지 않는다.
  /// TODO: 현재 규칙은 종류·굵기 필수, 검증 규칙 확인 필요
  NeedleRowError? validate() {
    if (isEmpty) return null;
    if (type == null) return NeedleRowError.missingType;
    if (_sizeText.isEmpty) return NeedleRowError.missingSize;
    if (!_sizePattern.hasMatch(_sizeText)) return NeedleRowError.invalidSize;
    return null;
  }

  Needle toNeedle() {
    final value = double.tryParse(_sizeText);
    // 굵기가 없으면 단위도 보내지 않는다.
    return Needle(type: type, unit: value == null ? null : unit, value: value);
  }

  void dispose() => sizeController.dispose();
}
