import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/data/models/image_model.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/presentation/view_models/record_form_view_model.dart';
import 'package:knittda/src/presentation/widgets/image_box.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

//기록 상태
enum RecordStatus {
  NOT_STARTED,
  STARTED,
  IN_PROGRESS,
  ALMOST_DONE,
  COMPLETED,
}

class EditRecord extends StatefulWidget {
  final RecordModel record;

  const EditRecord({super.key, required this.record});

  @override
  State<EditRecord> createState() => _EditRecordState();
}

class _EditRecordState extends State<EditRecord> {
  final List<String> _tags = [
    "푸르시오", "지쳤어요", "실수했어요", "함뜨했어요", "완벽 해요",
    "실이 부족해요", "무한 메리야스 뜨기", "무늬 뜨기", "배색 뜨기",
    "뿌듯해요", "힘들어요", "성공했어요"
  ];
  final Set<String> _selectedTags = {};
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = [];

  RecordStatus? _selectedStatus;
  final TextEditingController _commentController = TextEditingController();

  final List<ImageModel> _serverImages = [];
  final List<int> _deleteImageIds = [];

  Future<void> _pickImage(ImageSource source) async {
    if (_images.length >= 5) return;

    final XFile? picked = await _picker.pickImage(
      source: source,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    if (picked != null) {
      setState(() => _images.add(picked));
    }
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('카메라로 촬영'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('갤러리에서 선택'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedTags.addAll(widget.record.tags ?? []);

    final match = RecordStatus.values.where(
          (e) => e.name == widget.record.recordStatus,
    );
    _selectedStatus = match.isNotEmpty ? match.first : null;

    _commentController.text = widget.record.comment ?? '';

    _serverImages.addAll(widget.record.images ?? []);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitRecord() async {
    final recordFormViewModel = context.read<RecordFormViewModel>();
    if (recordFormViewModel.isSaving) return;

    if (_selectedStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('진행 상태를 선택해주세요.')));
      return;
    }
    if (_commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('기록을 남겨주세요.')));
      return;
    }

    final updatedRecord = widget.record.copyWith(
      recordStatus: _selectedStatus!.name,
      tags: _selectedTags.toList(),
      comment: _commentController.text.trim(),
      files: _images,
    );

    final saved = await recordFormViewModel.save(updatedRecord, deleteImageIds: _deleteImageIds);

    if (!mounted) return;

    if (saved != null) {
      Navigator.pop(context);
    } else {
      final error = recordFormViewModel.error ?? '수정에 실패했습니다.';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    }

  }

  @override
  Widget build(BuildContext context) {
    final recordFormViewModel = context.watch<RecordFormViewModel>();
    final isBusy = recordFormViewModel.isSaving;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("기록 수정"),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: isBusy ? null : _submitRecord,
                style: TextButton.styleFrom(
                  backgroundColor: PRIMARY_COLOR,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  '저장',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: AbsorbPointer(
            absorbing: isBusy,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  //태그 선택
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //WorkListItem(work: widget.record.projectId),
                        //const SizedBox(height: 35),

                        const Text("오늘 뜨개는 어떠셨어요?", style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _tags.map((option) {
                            final isSelected = _selectedTags.contains(option);
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelected
                                      ? _selectedTags.remove(option)
                                      : _selectedTags.add(option);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected ? PRIMARY_COLOR : Colors.grey.shade600,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    color: isSelected ? PRIMARY_COLOR : Colors.black87,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),

                  //record 상태
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '얼마나 떴나요?',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 40),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // 배경 선
                            Container(
                              height: 2,
                              width: double.infinity,
                              color: Colors.grey[300],
                            ),

                            // 원들
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: RecordStatus.values.map((status) {
                                final isSelected = status == _selectedStatus;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedStatus = status;
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: isSelected ? PRIMARY_COLOR : Colors.grey[300],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 26),
                      ],
                    ),
                  ),

                  const Divider(color: Color(0xFFE0E0E0), thickness: 8, height: 40),

                  // 사진 추가
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("사진을 추가해주세요", style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              // 서버에서 온 이미지들
                              ..._serverImages.asMap().entries.map((entry) {
                                final index = entry.key;
                                final image = entry.value;

                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: ImageBox(
                                    networkImageUrl: image.imageUrl,
                                    width: 100,
                                    height: 100,
                                    onRemove: () {
                                      setState(() {
                                        _deleteImageIds.add(image.id);
                                        _serverImages.removeAt(index);
                                      });
                                    },
                                  ),
                                );
                              }),

                              // 새로 추가한 이미지들
                              ..._images.asMap().entries.map((entry) {
                                final index = entry.key;
                                final image = entry.value;

                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: ImageBox(
                                    localImageUrl: image.path,
                                    width: 100,
                                    height: 100,
                                    onRemove: () {
                                      setState(() {
                                        _images.removeAt(index);
                                      });
                                    },
                                  ),
                                );
                              }),

                              // 이미지 추가 버튼 (최대 5장 제한)
                              if (_serverImages.length + _images.length < 5)
                                GestureDetector(
                                  onTap: _showImageSourceActionSheet,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: const Icon(Icons.add, color: Colors.grey, size: 30),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 26),
                      ],
                    ),
                  ),

                  // 텍스트 입력
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("뜨개 기록을 남겨주세요", style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 16),
                        TextField(
                          maxLines: 8,
                          keyboardType: TextInputType.multiline,
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: "내용을 입력하세요",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
        if (isBusy)
          const Positioned.fill(
            child: ColoredBox(
              color: Colors.black26,
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}