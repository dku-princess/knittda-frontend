import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/presentation/widgets/listitems/work_list_item.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddDiary extends StatefulWidget {
  final WorkModel work;

  const AddDiary({super.key, required this.work});

  @override
  State<AddDiary> createState() => _AddDiaryState();
}

class _AddDiaryState extends State<AddDiary> {
  final List<String> _options = [
    "푸르시오", "지쳤어요", "실수했어요", "함뜨했어요", "완벽 해요",
    "실이 부족해요", "무한 메리야스 뜨기", "무늬 뜨기", "배색 뜨기",
    "뿌듯해요", "힘들어요", "성공했어요"
  ];

  final Set<String> _selectedOptions = {};
  final ImagePicker _picker = ImagePicker();
  List<XFile> _images = [];

  Future<void> _showImageSourceDialog() async {
    showModalBottomSheet(
      context: context,
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
                  final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                  if (photo != null) {
                    setState(() {
                      _images.add(photo);
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('갤러리에서 선택'),
                onTap: () async {
                  Navigator.pop(context);
                  final List<XFile>? picked = await _picker.pickMultiImage();
                  if (picked != null && picked.isNotEmpty) {
                    setState(() {
                      _images.addAll(picked);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("기록 추가"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 상단 Work + 감정 선택
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WorkListItem(work: widget.work),
                  const SizedBox(height: 35),
                  const Text(
                    "오늘은 어떠셨어요?",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _options.map((option) {
                      final isSelected = _selectedOptions.contains(option);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected
                                ? _selectedOptions.remove(option)
                                : _selectedOptions.add(option);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.teal.shade50 : Colors.transparent,
                            border: Border.all(
                              color: isSelected ? Colors.teal : Colors.grey.shade600,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            option,
                            style: TextStyle(
                              color: isSelected ? Colors.teal.shade700 : Colors.black87,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 26),
                ],
              ),
            ),

            // Divider
            const Divider(
              color: Color(0xFFE0E0E0),
              thickness: 8,
              height: 40,
            ),

            // 2. 사진 추가 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "사진을 추가해주세요",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _showImageSourceDialog,
                    icon: const Icon(Icons.add_a_photo),
                    label: const Text("사진 추가"),
                  ),
                  const SizedBox(height: 12),
                  if (_images.isNotEmpty)
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _images.asMap().entries.map((entry) {
                        final index = entry.key;
                        final image = entry.value;
                        return Stack(
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
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.close, size: 18, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 26),
                ],
              ),
            ),

            // Divider
            const Divider(
              color: Color(0xFFE0E0E0),
              thickness: 8,
              height: 40,
            ),

            // 3. 텍스트 기록 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "기록을 남겨주세요",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
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
          ],
        ),
      ),
    );
  }
}