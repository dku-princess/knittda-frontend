import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/presentation/view_models/record_form_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_list_view_model.dart';
import 'package:knittda/src/presentation/widgets/image_box.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:math';

//기록 아이디어를 위한 문장 리스트
final List<String> knittingPrompts = [
  "뜨개질하면서 어떤 생각을 하셨나요?",
  "실의 촉감은 어땠나요?",
  "이번 패턴은 어려웠나요, 쉬웠나요?",
  "하루 중 언제 뜨개를 하셨나요?",
  "누구를 떠올리며 만들었나요?",
  "이전 기록과 비교해서 어떤가요?",
  "오늘은 몇 줄이나 떴나요?",
  "실수는 없었나요?",
  "멋진 뜨개 여정, 뜨다와 함께 해 주셔서 감사합니다!",
  "오늘 뜨개 시간이 힐링이 되었나요?",
  "감정을 색으로 표현한다면?",
  "이 작품은 누구에게 주실 계획인가요?",
  "완성까지 얼마나 걸릴 것 같나요?",
  "오늘의 뜨개 제목을 붙여보자면?",
  "오늘도 한 페이지를 써내려가는 당신, 멋진 뜨개인!",
  "오늘의 실 구매처는?",
  "어떤 패턴 참고하셨나요?",
  "기억하고 싶은 특별한 순간이 있었나요?",
  "오늘 기분은 10점 만 점에 몇 점인가요?",
  "패턴 수정한 부분이 있나요?",
  "오늘 뜨개 진도는 얼마나 나갔나요? 사실, 꾸준함이 중요하죠!",
  "오늘은 어떤 음악을 들으며 뜨개를 했나요?"
];

final String randomPrompt = (knittingPrompts..shuffle()).first;


//기록 상태
enum RecordStatus {
  NOT_STARTED,
  STARTED,
  IN_PROGRESS,
  ALMOST_DONE,
  COMPLETED,
}

class AddRecord extends StatefulWidget {
  final WorkModel work;

  const AddRecord({super.key, required this.work});

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
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
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitRecord() async {
    final recordFormVM = context.read<RecordFormViewModel>();

    if (recordFormVM.isSaving) return;

    if (_selectedStatus == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('진행 상태를 선택해주세요.')));
      return;
    }
    if (_commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('기록을 남겨주세요.')));
      return;
    }

    final saved = await recordFormVM.save(
      RecordModel.forCreate(
        projectId: widget.work.id!,
        recordStatus: _selectedStatus!.name,
        tags: _selectedTags.toList(),
        comment: _commentController.text.trim(),
        files: _images,
      ),
    );

    if (!mounted) return;

    if (saved == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(recordFormVM.error ?? '알 수 없는 오류')),
      );
      return;
    }

    await context.read<WorkListViewModel>().refresh();
    if (!mounted) return;

    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    final recordFormVM = context.watch<RecordFormViewModel>();
    final isBusy = recordFormVM.isSaving;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('기록 추가', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
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

                  // 태그 선택
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //WorkListItem(work: widget.work),
                        //const SizedBox(height: 35),

                        const Text("오늘은 뜨개는 어떠셨어요?", style: TextStyle(fontSize: 20)),
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

                              // + 버튼
                              if (_images.length < 5)
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
                        Text(
                          randomPrompt,
                          style: const TextStyle(fontSize: 20, color: Colors.grey),
                        ),
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