import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/domain/model/images.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_event.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_ui_event.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_view_model.dart';
import 'package:knittda/src/presentation/widgets/image_box.dart';
import 'package:provider/provider.dart';

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
  }

  Future<void> _saveRecord() async {
    final viewModel = context.read<AddEditRecordViewModel>();

    if (viewModel.state.isLoading) return;

    final tags = _selectedTags.toList();
    final recordStatus = _recordStatus;
    final comment = _commentController.text.trim();

    if (recordStatus == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('진행 상태를 선택해주세요.')));
      return;
    }
    if (comment.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('기록을 남겨주세요.')));
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
          appBar: AppBar(
            scrolledUnderElevation: 0,
            title: Text(
              widget.record != null ? '기록 수정' : '기록 추가',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            actions: [
              //저장버튼
              TextButton(
                onPressed: state.isLoading ? null : _saveRecord,
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

            children: [
              //태그 선택
              Text(
                "오늘 뜨개는 어떠셨어요?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
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
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? PRIMARY_COLOR : Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? PRIMARY_COLOR : Colors.grey,
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
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 20,
                      right: 20,
                      child: Container(height: 2, color: Colors.grey[300]),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _statusValues.map((status) {
                        final bool isSelected = _recordStatus == status;

                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() {
                              _recordStatus = status;
                            });
                          },
                          child: SizedBox(
                            width: 44,
                            height: 44,
                            child: Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? PRIMARY_COLOR
                                      : Colors.grey[300],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              Text(
                "사진을 추가해주세요.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ..._existingImages.map((image) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
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
                        padding: const EdgeInsets.only(right: 10.0),
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
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              size: 32,
                              color: Colors.grey,
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
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              if (questionText != null) ...[
                Text(
                  questionText,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 12),
              ],
              const SizedBox(height: 20),
              //기록 추가
              TextField(
                maxLines: 8,
                maxLength: 300,
                keyboardType: TextInputType.multiline,
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: "내용을 입력해주세요",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),

        if (state.isLoading)
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
