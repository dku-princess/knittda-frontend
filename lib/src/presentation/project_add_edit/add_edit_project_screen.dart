import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/knittda_snack_bar.dart';
import 'package:knittda/src/presentation/widgets/knittda_app_bar.dart';
import 'package:knittda/src/presentation/widgets/knittda_button.dart';
import 'package:knittda/src/presentation/widgets/knittda_loading.dart';
import 'package:knittda/src/presentation/widgets/knittda_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_event.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_ui_event.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_view_model.dart';
import 'package:knittda/src/presentation/widgets/image_box.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/core/theme/theme.dart';

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
  XFile? _image;
  String? _thumbnailUrl;
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
    _yarnInfoController.dispose();
    _needleInfoController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 70,
    );

    if (!mounted) return;

    if (picked != null) {
      setState(() {
        _image = picked;
      });
    }
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

    final hasImage = _image != null || (_thumbnailUrl?.isNotEmpty ?? false);

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
          file: _image,
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
          file: _image,
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
          appBar: KnittdaAppBar(
            title: widget.project != null ? '작품 수정' : '작품 추가',
            actions: [
              //저장버튼
              KnittdaButton(
                label: '저장',
                onPressed: viewModel.state.isLoading ? null : _saveProject,
              ),
              const SizedBox(width: AppSpacing.space8),
            ],
          ),

          body: ListView(
            padding: const EdgeInsets.only(
              left: AppSpacing.space20,
              right: AppSpacing.space20,
              top: AppSpacing.space20,
              bottom: AppLayout.contentBottomInset,
            ),

            //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "기본 정보",
                  style: AppTextStyles.title,
                ),
              ),
              SizedBox(height: AppSpacing.space12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 대표 사진
                  Text(
                    "대표 사진",
                    style: AppTextStyles.heading,
                  ),
                  SizedBox(height: AppSpacing.space12),
                  GestureDetector(
                    onTap: _pickImage,
                    child:
                    (_image != null ||
                        (_thumbnailUrl?.isNotEmpty ?? false))
                        ? ImageBox(
                      localImageUrl: _image?.path,
                      networkImageUrl: _thumbnailUrl,
                      width: 115,
                      height: 115,
                      onRemove: () {
                        setState(() {
                          _image = null;
                          _thumbnailUrl = null;
                        });
                      },
                    )
                        : Container(
                      width: 115,
                      height: 115,
                      decoration: BoxDecoration(
                        color: AppColors.grey200,
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: AppColors.white,
                          size: AppIconSize.xl,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.space16),

                  Text(
                    "작품 이름",
                    style: AppTextStyles.heading,
                  ),
                  SizedBox(height: AppSpacing.space12),
                  KnittdaInput(
                    controller: _nicknameController,
                    maxLength: 15,
                  ),

                  Text(
                    "시작일 ~ 목표일",
                    style: AppTextStyles.heading,
                  ),
                  SizedBox(height: AppSpacing.space12),
                  GestureDetector(
                    onTap: () => _pickDateRange(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space16,
                        vertical: AppSpacing.space12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(AppRadius.button),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: AppIconSize.md),
                          const SizedBox(width: AppSpacing.space12),
                          Text(
                            (_startDate != null && _goalDate != null)
                                ? '${DateUtilsHelper.toHyphenFormat(_startDate!)} ~ ${DateUtilsHelper.toHyphenFormat(_goalDate!)}'
                                : 'yyyy-mm-dd ~ yyyy-mm-dd',
                            style: AppTextStyles.body.copyWith(
                              color: (_startDate != null && _goalDate != null)
                                  ? AppColors.black
                                  : AppColors.textHint,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.space40),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "디자인",
                  style: AppTextStyles.title,
                ),
              ),
              SizedBox(height: AppSpacing.space12),

              Text(
                "도안명",
                style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.space12),
              KnittdaInput(
                controller: _designTitleController,
                maxLength: 15,
              ),
              SizedBox(height: AppSpacing.space16),

              Text(
                "작가",
                style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.space12),
              KnittdaInput(
                controller: _designerController,
                maxLength: 15,
              ),
              SizedBox(height: AppSpacing.space16),

              Text(
                "실",
                style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.space12),
              KnittdaInput(
                controller: _yarnInfoController,
                maxLength: 15,
              ),
              SizedBox(height: AppSpacing.space16),

              Text(
                "바늘",
                style: AppTextStyles.heading,
              ),
              SizedBox(height: AppSpacing.space12),
              KnittdaInput(
                controller: _needleInfoController,
                maxLength: 15,
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
