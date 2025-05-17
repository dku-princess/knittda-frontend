import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/presentation/view_models/work_view_model.dart';
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
  String? _goalDate;

  Future<void> _pickImageFromGallery() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = picked;
      });
    }
  }

  Future<void> _pickGoalDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: '목표 날짜 선택',
    );

    if (picked != null) {
      setState(() {
        _goalDate = DateUtilsHelper.toDotFormat(picked);
      });
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _designController.dispose();
    _designerController.dispose();
    _yarnController.dispose();
    _needleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WorkVM = context.watch<WorkViewModel>();
    final isBusy = WorkVM.isLoading;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('작품 추가', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            centerTitle: true,
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
                        GestureDetector(
                          onTap: _pickImageFromGallery,
                          child: Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                              image: _image != null
                                  ? DecorationImage(
                                image: FileImage(File(_image!.path)),
                                fit: BoxFit.cover,
                              )
                                  : null,
                            ),
                            child: _image == null
                                ? Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 50,
                            )
                                : null,
                          ),
                        ),
                        SizedBox(width: 16),
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
                                child: Text(_goalDate ?? "목표 날짜"),
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
                      trailing: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          // 검색 아이콘 클릭 시 동작
                          print("검색 클릭됨");
                        },
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
                      readOnly: true,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          //borderSide: BorderSide.none,
                        ),
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
                      readOnly: true,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          //borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 26),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "정보",
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
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: TextButton(
                        onPressed: isBusy
                            ? null
                            : () async {
                          final nickname = _nicknameController.text.trim();
                          final customYarnInfo = _yarnController.text.trim();
                          final customNeedleInfo = _needleController.text.trim();
                          //final customDesign = _designController.text.trim();
                          //final customDesigner = _designerController.text.trim();

                          if (nickname.isEmpty || _goalDate == null || _goalDate!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('작품 이름과 목표 날짜를 설정 해주세요!')),
                            );
                            return;
                          }

                          final work = WorkModel.forCreate(
                            //designId: designId ?? 1,
                            nickname: nickname,
                            customYarnInfo: customYarnInfo,
                            customNeedleInfo: customNeedleInfo,
                            goalDate: DateUtilsHelper.fromDotFormat(_goalDate!),
                          );

                          final success = await WorkVM.createWork(work);
                          if (!mounted) return;

                          if (success) {
                            //WorkList로 이동
                            WorkVM.reset();
                          } else {
                            final error = WorkVM.errorMessage ?? '알 수 없는 오류';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error)),
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
                        child: Text(
                          "작품 추가하기",
                        ),
                      ),
                    ),
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