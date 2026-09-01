import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/domain/model/default_thumbnail.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_event.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_ui_event.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_view_model.dart';
import 'package:provider/provider.dart';

enum _ThumbnailSource { galleryImage, defaultImage }

class AddEditProjectScreen extends StatefulWidget {
  final Project? project;

  const AddEditProjectScreen({super.key, this.project});

  @override
  State<AddEditProjectScreen> createState() => _AddEditProjectScreenState();
}

class _AddEditProjectScreenState extends State<AddEditProjectScreen> {
  final _nicknameController = TextEditingController();
  final _designTitleController = TextEditingController();
  final _designerController = TextEditingController();
  final _needleInfoController = TextEditingController();
  final _yarnInfoController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  // _thumbnailUrl: 작품 썸네일. 수정 화면 진입 시 서버의 기존 값으로 채워짐.
  // _galleryImage: 갤러리 이미지. 이번 세션에 갤러리에서 새로 고른 로컬 파일.
  // _defaultThumbnailId: 기본 이미지. 서버 기본 이미지 목록 중 고른 항목 id.
  String? _thumbnailUrl;
  XFile? _galleryImage;
  int? _defaultThumbnailId;

  // 갤러리 이미지와 기본 이미지 중 어디에 포커싱 되어있는지
  _ThumbnailSource? _focusedSource;

  static const double _thumbnailBoxSize = 100;

  DateTime? _goalDate;
  DateTime? _startDate;

  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    if (widget.project != null) {
      _nicknameController.text = widget.project!.nickname;

      final design = widget.project!.design;
      if (design != null) {
        _designTitleController.text = design.title ?? '';
        _designerController.text = design.designer ?? '';
        _yarnInfoController.text = design.yarnInfo ?? '';
        _needleInfoController.text = design.needleInfo ?? '';
      }

      if (widget.project!.thumbnailUrl != null &&
          widget.project!.thumbnailUrl!.isNotEmpty) {
        _thumbnailUrl = widget.project!.thumbnailUrl;
      }

      _goalDate = widget.project?.goalDate != null
          ? DateTime.tryParse(widget.project!.goalDate)
          : null;

      _startDate = widget.project?.startDate != null
          ? DateTime.tryParse(widget.project!.startDate)
          : null;
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
                final snackBar = SnackBar(content: Text(message));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    _yarnInfoController.dispose();
    _needleInfoController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  // 갤러리에서 사진을 선택 -> 갤러리 이미지를 포커싱 상태로 전환
  Future<void> _pickGalleryImage() async {
    final picked = await picker.pickImage(
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

  void _focusGalleryImage() {
    setState(() {
      _focusedSource = _ThumbnailSource.galleryImage;
    });
  }

  // gallery-box의 X 버튼 -> 전체 초기화
  void _clearGalleryImage() {
    setState(() {
      _galleryImage = null;
      _thumbnailUrl = null;
      _defaultThumbnailId = null;
      _focusedSource = null;
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
    // 일치하면 해당 기본 이미지를 포커싱
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

  Future<void> _pickDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: (_startDate != null && _goalDate != null)
          ? DateTimeRange(start: _startDate!, end: _goalDate!)
          : null,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: '시작일과 목표일 선택',
      saveText: '확인',
    );

    if (!mounted) return;

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _goalDate = picked.end;
      });
    }
  }

  Future<void> _saveProject() async {
    final viewModel = context.read<AddEditProjectViewModel>();

    final nickname = _nicknameController.text.trim();
    final customYarnInfo = _yarnInfoController.text.trim();
    final customNeedleInfo = _needleInfoController.text.trim();
    final designTitle = _designTitleController.text.trim();
    final designer = _designerController.text.trim();

    final hasImage =
        _focusedSource != null || (_thumbnailUrl?.isNotEmpty ?? false);

    if (nickname.isEmpty ||
        _goalDate == null ||
        _startDate == null ||
        !hasImage) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('기본 정보를 모두 입력해주세요.')));
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
          appBar: AppBar(
            scrolledUnderElevation: 0,
            title: Text(
              widget.project != null ? '작품 수정' : '작품 추가',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            actions: [
              //저장버튼
              TextButton(
                onPressed: viewModel.state.isLoading ? null : _saveProject,
                style: TextButton.styleFrom(
                  backgroundColor: PRIMARY_COLOR,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('저장', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(width: 8),
            ],
          ),

          body: ListView(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 20,
              bottom: 50,
            ),

            //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "기본 정보",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 대표 사진
                  Text(
                    "대표 사진",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12),

                  _buildThumbnailList(viewModel.state.defaultThumbnails),

                  SizedBox(height: 14),

                  Text(
                    "작품 이름",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _nicknameController,
                    maxLines: 1,
                    maxLength: 15,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),

                  Text(
                    "시작일 ~ 목표일",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => _pickDateRange(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            (_startDate != null && _goalDate != null)
                                ? '${DateUtilsHelper.toHyphenFormat(_startDate!)} ~ ${DateUtilsHelper.toHyphenFormat(_goalDate!)}'
                                : 'yyyy-mm-dd ~ yyyy-mm-dd',
                            style: TextStyle(
                              fontSize: 14,
                              color: (_startDate != null && _goalDate != null)
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "디자인",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10),

              Text(
                "도안명",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _designTitleController,
                maxLines: 1,
                maxLength: 15,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
              SizedBox(height: 14),

              Text(
                "작가",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _designerController,
                maxLines: 1,
                maxLength: 15,
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
              SizedBox(height: 14),

              Text(
                "실",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _yarnInfoController,
                maxLines: 1,
                maxLength: 15,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
              SizedBox(height: 14),

              Text(
                "바늘",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _needleInfoController,
                maxLines: 1,
                maxLength: 15,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),

        if (viewModel.state.isLoading)
          Positioned.fill(
            child: AbsorbPointer(
              child: Container(
                color: Colors.black26,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
      ],
    );
  }
}
