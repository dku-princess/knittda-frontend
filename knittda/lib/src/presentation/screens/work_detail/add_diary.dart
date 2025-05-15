//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/presentation/screens/work_detail/work_details.dart';
import 'package:knittda/src/presentation/view_models/record_view_model.dart';
import 'package:knittda/src/presentation/widgets/listitems/work_list_item.dart';

import 'dart:io';
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

class AddDiary extends StatefulWidget {
  final WorkModel work;

  const AddDiary({super.key, required this.work});

  @override
  State<AddDiary> createState() => _AddDiaryState();
}

class _AddDiaryState extends State<AddDiary> {
  final List<String> _tags = [
    "푸르시오", "지쳤어요", "실수했어요", "함뜨했어요", "완벽 해요",
    "실이 부족해요", "무한 메리야스 뜨기", "무늬 뜨기", "배색 뜨기",
    "뿌듯해요", "힘들어요", "성공했어요"
  ];
  final Set<String> _selectedTags = {};
  final ImagePicker _picker = ImagePicker();
  List<XFile> _images = [];

  RecordStatus? _selectedStatus;
  final TextEditingController _commentController = TextEditingController();

  Future<void> _pickImageFromGallery() async {

    if (_images.length >= 5) return;

    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _images.add(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final addRecordVM = context.watch<RecordViewModel>();
    final isBusy = addRecordVM.isLoading;   // 버튼 비활성 + 로딩 표시

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("기록 추가"),
          ),
          body: AbsorbPointer(
            absorbing: isBusy,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // 1. 작품 정보 + 감정 선택
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WorkListItem(work: widget.work),
                        const SizedBox(height: 35),
                        const Text("오늘은 어떠셨어요?", style: TextStyle(fontSize: 20)),
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

                  // 2. 사진 추가 영역
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
                              ..._images.asMap().entries.map((entry) {
                                final index = entry.key;
                                final image = entry.value;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          File(image.path),
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _images.removeAt(index);
                                            });
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.black54,
                                              shape: BoxShape.circle,
                                            ),
                                            padding: const EdgeInsets.all(2),
                                            child: const Icon(Icons.close, size: 16, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),

                              // + 버튼
                              if (_images.length < 5)
                                GestureDetector(
                                  onTap: _pickImageFromGallery,
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

                  // 3. 텍스트 입력
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("기록을 남겨주세요", style: TextStyle(fontSize: 20)),
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
                    child: SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: TextButton(
                        onPressed: isBusy // 중복클릭 방지
                          ? null
                          : () async {
                          if (_selectedStatus == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('진행 상태를 선택해주세요.')),
                            );
                            return;
                          }

                          if (_selectedTags.isEmpty &&
                              _commentController.text.trim().isEmpty &&
                              _images.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('태그를 선택하거나 사진 또는 기록을 남겨주세요.')),
                            );
                            return;
                          }

                          final record = RecordModel.forCreate(
                            projectId   : widget.work.id!,
                            recordStatus: _selectedStatus!.name,
                            tags        : _selectedTags.toList(),
                            comment     : _commentController.text.trim(),
                            recordedAt  : DateTime.now(),
                            files       : _images,
                          );

                          if (await addRecordVM.createRecord(record)) {
                            if (!mounted) return;

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => WorkDetails(
                                  projectId: widget.work.id!,
                                ),
                              ),
                            );

                            addRecordVM.reset();
                          } else if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  addRecordVM.errorMessage ?? '알 수 없는 오류',
                                ),
                              ),
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: PRIMARY_COLOR,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("기록 추가하기"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
        if (isBusy)
          const ColoredBox(
            color: Colors.black38,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}