import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/knittda_snack_bar.dart';
import 'package:knittda/src/presentation/widgets/knittda_app_bar.dart';
import 'package:knittda/src/presentation/widgets/knittda_button.dart';
import 'package:knittda/src/presentation/widgets/knittda_input.dart';
import 'package:knittda/src/presentation/widgets/knittda_loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/domain/model/images.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_event.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_ui_event.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_view_model.dart';
import 'package:knittda/src/presentation/widgets/image_box.dart';
import 'package:knittda/src/presentation/widgets/progress_stage_slider.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/core/theme/theme.dart';

class AddEditRecordScreen extends StatefulWidget {
  final int projectId;
  final Records? record;
  const AddEditRecordScreen({super.key, required this.projectId, this.record});

  @override
  State<AddEditRecordScreen> createState() => _AddEditRecordScreenState();
}

class _AddEditRecordScreenState extends State<AddEditRecordScreen> {
  StreamSubscription? _subscription;

  final List<String> _tags = [
    "푸르시오",
    "지쳤어요",
    "실수했어요",
    "함뜨했어요",
    "완벽 해요",
    "실이 부족해요",
    "무한 메리야스 뜨기",
    "무늬 뜨기",
    "배색 뜨기",
    "뿌듯해요",
    "힘들어요",
    "성공했어요",
  ];
  final Set<String> _selectedTags = {};

  String? _recordStatus;
  final List<String> _statusValues = const [
    "NOT_STARTED",
    "STARTED",
    "IN_PROGRESS",
    "ALMOST_DONE",
    "COMPLETED",
  ];

  final _commentController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final List<Images> _existingImages = [];
  final List<int> _deleteImageIds = [];
  final List<XFile> _newImages = [];

  @override
  void initState() {
    super.initState();

    final record = widget.record;
    if (record != null) {
      _selectedTags.addAll(record.tags ?? []);

      _recordStatus = record.recordStatus;

      _commentController.text = record.comment ?? '';

      _existingImages.addAll(record.images ?? []);
    }

    Future.microtask(() {
      if (mounted) {
        final viewModel = context.read<AddEditRecordViewModel>();

        _subscription = viewModel.eventStream.listen((event) {
          if (mounted) {
            switch (event) {
              case SavedRecord(:final record):
                Navigator.pop(context, record);
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
    _commentController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _showImageSourceSheet(BuildContext context) async {
    if (_existingImages.length + _newImages.length >= 5) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('카메라로 촬영'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('갤러리에서 선택'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    if (_existingImages.length + _newImages.length >= 5) return;

    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (file == null) return;
      if (!mounted) return;

      setState(() {
        if (_existingImages.length + _newImages.length < 5) {
          _newImages.add(file);
        }
      });
    } catch(_) {
      if (!mounted) return;
      KnittdaSnackBar.show(context, '카메라를 사용할 수 없습니다. 설정에서 권한을 확인해 주세요.', tone: KnittdaSnackTone.error);
    }
  }

  Future<void> _saveRecord() async {
    final viewModel = context.read<AddEditRecordViewModel>();

    if (viewModel.state.isLoading) return;

    final tags = _selectedTags.toList();
    final recordStatus = _recordStatus;
    final comment = _commentController.text.trim();

    if (recordStatus == null) {
      KnittdaSnackBar.show(context, '진행 상태를 선택해주세요.', tone: KnittdaSnackTone.info);
      return;
    }
    if (comment.isEmpty) {
      KnittdaSnackBar.show(context, '기록을 남겨주세요.', tone: KnittdaSnackTone.info);
      return;
    }

    if (widget.record == null) {
      viewModel.onEvent(
        AddEditRecordEvent.saveRecord(
          record: Records(
            projectId: widget.projectId,
            recordStatus: recordStatus,
            tags: tags,
            comment: comment,
            question: viewModel.state.questionState.question,
          ),
          files: _newImages,
        ),
      );
    } else {
      viewModel.onEvent(
        AddEditRecordEvent.saveRecord(
          record: widget.record!.copyWith(
            recordId: widget.record!.id,
            projectId: widget.projectId,
            recordStatus: recordStatus,
            tags: tags,
            comment: comment,
          ),
          deleteImageIds: _deleteImageIds,
          files: _newImages,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddEditRecordViewModel>();
    final state = viewModel.state;

    final questionState = state.questionState;
    String? questionText;
    if (widget.record == null) {
      if (questionState.isLoading) {
        questionText = '질문을 불러오는 중입니다..';
      } else if (questionState.question.isNotEmpty) {
        questionText = questionState.question;
      }
    }

    return Stack(
      children: [
        Scaffold(
          appBar: KnittdaAppBar(
            title: widget.record != null ? '기록 수정' : '기록 추가',
            actions: [
              //저장버튼
              KnittdaButton(
                label: '저장',
                onPressed: state.isLoading ? null : _saveRecord,
              ),
              const SizedBox(width: AppSpacing.space8),
            ],
          ),

          body: ListView(
            padding: const EdgeInsets.only(
              left: AppSpacing.space20,
              right: AppSpacing.space20,
              top: AppSpacing.space20,
              bottom: 50,
            ),

            children: [
              //태그 선택
              Text(
                "오늘 뜨개는 어떠셨어요?",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: AppFontSize.xl,
                  fontWeight: AppFontWeight.medium,
                ),
              ),
              const SizedBox(height: AppSpacing.space20),
              Wrap(
                spacing: 8,
                runSpacing: 10,
                children: _tags.map((tag) {
                  final isSelected = _selectedTags.contains(tag);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedTags.remove(tag);
                        } else {
                          _selectedTags.add(tag);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space8,
                        vertical: AppSpacing.space8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: Border.all(
                          color: isSelected ? PRIMARY_COLOR : AppColors.grey400,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: AppFontSize.sm,
                          color: isSelected ? PRIMARY_COLOR : AppColors.grey400,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 50),

              //select recordStatus
              Text(
                "얼마나 떴나요?",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: AppFontSize.xl,
                  fontWeight: AppFontWeight.medium,
                ),
              ),
              const SizedBox(height: AppSpacing.space20),
              ProgressStageSlider(
                labels: const ['시작 전', '시작', '진행 중', '거의 완성', '완성'],
                selectedIndex: _recordStatus == null
                    ? null
                    : _statusValues.indexOf(_recordStatus!),
                onChanged: (index) {
                  setState(() {
                    _recordStatus = _statusValues[index];
                  });
                },
              ),

              const SizedBox(height: 50),

              Text(
                "사진을 추가해주세요.",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: AppFontSize.xl,
                  fontWeight: AppFontWeight.medium,
                ),
              ),
              const SizedBox(height: AppSpacing.space20),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ..._existingImages.map((image) {
                      return Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.space8),
                        child: ImageBox(
                          localImageUrl: null,
                          networkImageUrl: image.imageUrl,
                          width: 100,
                          height: 100,
                          onRemove: () {
                            setState(() {
                              _existingImages.remove(image);
                              _deleteImageIds.add(image.id);
                            });
                          },
                        ),
                      );
                    }),

                    ..._newImages.map((file) {
                      return Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.space8),
                        child: ImageBox(
                          localImageUrl: file.path,
                          networkImageUrl: null,
                          width: 100,
                          height: 100,
                          onRemove: () {
                            setState(() {
                              _newImages.remove(file);
                            });
                          },
                        ),
                      );
                    }),

                    if (_existingImages.length + _newImages.length < 5)
                      GestureDetector(
                        onTap: () => _showImageSourceSheet(context),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppRadius.button),
                            border: Border.all(color: AppColors.grey400),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              size: AppIconSize.lg,
                              color: AppColors.grey400,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              Text(
                "뜨개 기록을 남겨주세요",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: AppFontSize.xl,
                  fontWeight: AppFontWeight.medium,
                ),
              ),
              const SizedBox(height: AppSpacing.space12),
              if (questionText != null) ...[
                Text(
                  questionText,
                  style: const TextStyle(color: AppColors.grey400, fontSize: AppFontSize.md),
                ),
                const SizedBox(height: AppSpacing.space12),
              ],
              const SizedBox(height: AppSpacing.space20),
              //기록 추가
              KnittdaInput(
                controller: _commentController,
                hintText: "내용을 입력해주세요",
                maxLines: 8,
                maxLength: 300,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),

        if (state.isLoading)
          const Positioned.fill(child: KnittdaLoadingOverlay()),
      ],
    );
  }
}
