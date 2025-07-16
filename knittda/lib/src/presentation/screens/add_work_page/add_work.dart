import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/presentation/view_models/work_view_model.dart';
import 'package:knittda/src/presentation/widgets/image_box.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/data/models/work_model.dart';

class AddWork extends StatefulWidget {
  const AddWork({super.key});

  @override
  State<AddWork> createState() =>_AddWorkState();
}

class _AddWorkState extends State<AddWork> {
  final _nicknameController = TextEditingController();
  final _designController = TextEditingController();
  final _designerController = TextEditingController();
  final _yarnController = TextEditingController();
  final _needleController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  DateTime? _goalDate;
  bool _submitting = false;

  @override
  void dispose() {
    _nicknameController.dispose();
    _designController.dispose();
    _designerController.dispose();
    _yarnController.dispose();
    _needleController.dispose();
    super.dispose();
  }

  // 갤러리에서 이미지 선택 함수
  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      //imageQuality: 85,//이미지 압축률
    );
    if (picked != null) {
      setState(() {
        _image = picked;
      });
    }
  }

  // 캘린더에서 목표날짜 선택 함수
  Future<void> _pickGoalDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      helpText: '목표 날짜 선택',
    );

    if (picked != null) {
      setState(() {
        _goalDate = picked;
      });
    }
  }

  // 저장 함수
  Future<void> _submitWork() async {
    if (_submitting) return;
    setState(() => _submitting = true);
    try {
      final nickname = _nicknameController.text.trim();
      final customYarnInfo = _yarnController.text.trim();
      final customNeedleInfo = _needleController.text.trim();
      final design = _designController.text.trim();
      final designer = _designerController.text.trim();

      if (nickname.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('작품 이름을 작성해주세요.')),
        );
        setState(() => _submitting = false);
        return;
      }

      if (_goalDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('목표 날짜를 선택해주세요.')),
        );
        setState(() => _submitting = false);
        return;
      }

      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('이미지를 선택해주세요.')),
        );
        setState(() => _submitting = false);
        return;
      }

      final now = DateTime.now();


      final work = WorkModel.forCreate(
        nickname: nickname,
        customYarnInfo: customYarnInfo.isNotEmpty ? customYarnInfo : null,
        customNeedleInfo: customNeedleInfo.isNotEmpty ? customNeedleInfo : null,
        startDate: now,
        goalDate: _goalDate!,
        file: _image!,
        designTitle: design.isNotEmpty ? design : null,
        designer: designer.isNotEmpty ? designer : null,
      );

      final viewModel = context.read<WorkViewModel>();
      final success = await viewModel.createWork(work);

      if (!mounted) return;

      if (success) {
        Navigator.pop(context);
      } else {
        final error = viewModel.error ?? '알 수 없는 오류';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WorkViewModel>();
    final isBusy = viewModel.isLoading || _submitting;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('작품 추가', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            centerTitle: true,
            actions: [
              //저장 버튼
              TextButton(
                onPressed: isBusy ? null : _submitWork,
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

          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: AbsorbPointer(
              absorbing: isBusy,
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "기본 정보",
                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        // 대표 사진
                        GestureDetector(
                          onTap: _pickImage,
                          child: ImageBox(
                            localImageUrl: _image?.path,
                            width: 110,
                            height: 110,
                            showIcon: _image == null, // 이미지가 없으면 + 아이콘
                            onRemove: _image != null
                                ? () {
                              setState(() {
                                _image = null;
                              });
                            }
                                : null,
                          ),
                        ),
                        const SizedBox(width: 16),

                        // 작품 이름, 목표 날짜
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller:_nicknameController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: "작품이름",
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: const TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 10),

                              TextButton(
                                onPressed: (){
                                  _pickGoalDate(context);
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: PRIMARY_COLOR,
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(color: PRIMARY_COLOR),
                                  ),
                                ),
                                child: Text(
                                  _goalDate != null ? DateUtilsHelper.toDotFormat(_goalDate!) : "목표 날짜",
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 50),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "도안",
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
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _designController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 16),

                    Text(
                      "작가",
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _designerController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 26),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "뜨개 정보",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Text(
                      "실",
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _yarnController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 16),

                    Text(
                      "바늘",
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _needleController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),

                    SizedBox(height: 40,),

                  ],
                ),
              ),
            ),
          ),
        ),
        if (isBusy)
          const ColoredBox(
            color: Colors.black26,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}