import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/models/design_model.dart';
import 'package:knittda/src/data/repositories/design_repositories.dart';
import 'package:knittda/src/domain/use_case/search_design_use_case.dart';
import 'package:knittda/src/presentation/screens/add_work_page/search_patterns.dart';
import 'package:knittda/src/presentation/view_models/edit_work_view_model.dart';
import 'package:knittda/src/presentation/view_models/search_view_model.dart';
import 'package:knittda/src/presentation/widgets/image_box.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/data/models/work_model.dart';

class EditWork extends StatefulWidget {
  final WorkModel work;

  const EditWork({
    super.key,
    required this.work,
  });

  @override
  State<EditWork> createState() =>_EditWorkState();
}

class _EditWorkState extends State<EditWork> {
  final _nicknameController = TextEditingController();
  final _designController = TextEditingController();
  final _designerController = TextEditingController();
  final _yarnController = TextEditingController();
  final _needleController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _goalDate;
  DesignModel? _selectedDesign;
  String? _networkImageUrl;

  Future<void> _pickImageFromGallery() async {
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
  void initState() {
    super.initState();
    _nicknameController.text = widget.work.nickname;

    final design = widget.work.designDto;

    if (design != null &&
        (design.title?.trim().isNotEmpty == true || design.designer?.trim().isNotEmpty == true)) {
      _selectedDesign = design;
      _designController.text = design.title ?? '';
      _designerController.text = design.designer ?? '';
    } else {
      _designController.text = '';
      _designerController.text = '';
    }

    _yarnController.text = widget.work.customYarnInfo ?? '';
    _needleController.text = widget.work.customNeedleInfo ?? '';

    if (widget.work.goalDate != null) {
      _goalDate = DateUtilsHelper.toDotFormat(widget.work.goalDate!);
    }

    if (widget.work.image?.imageUrl != null && widget.work.image!.imageUrl.isNotEmpty) {
      _networkImageUrl = widget.work.image!.imageUrl;
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
    final EditWorkVM = context.read<EditWorkViewModel>();
    final isBusy = EditWorkVM.isLoading;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('작품 수정', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
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
                          child: ImageBox(
                            localImageUrl: _image?.path,
                            networkImageUrl: _networkImageUrl,
                            width: 110,
                            height: 110,
                            showIcon: _image == null && (_networkImageUrl?.isEmpty ?? true),
                            onRemove: (_image != null || (_networkImageUrl?.isNotEmpty ?? false))
                                ? () {
                              setState(() {
                                _image = null;
                                _networkImageUrl = null;
                              });
                            }
                                : null,
                          ),
                        ),
                        const SizedBox(width: 16),
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
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) => SearchViewModel(searchDesignUseCase: SearchDesignUseCase(designRepositories: DesignRepositories())),
                                child: SearchPatterns(),
                              ),
                            ),
                          );

                          if (result != null && result is DesignModel) {
                            setState(() {
                              _designController.text = result.title ?? '';
                              _designerController.text = result.designer ?? '';
                              _selectedDesign = result;
                            });
                          }
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
                      readOnly: _selectedDesign != null,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: _selectedDesign != null,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        suffixIcon: _selectedDesign != null
                            ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              _selectedDesign = null;
                              _designController.clear();
                              _designerController.clear();
                            });
                          },
                        )
                            : null,
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
                      readOnly: _selectedDesign != null,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: _selectedDesign != null,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        suffixIcon: _selectedDesign != null
                            ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              _selectedDesign = null;
                              _designController.clear();
                              _designerController.clear();
                            });
                          },
                        )
                            : null,
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
                          final title = _designController.text.trim();
                          final designer = _designerController.text.trim();

                          if (nickname.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('작품 이름을 작성해주세요.')),
                            );
                            return;
                          }

                          if (_goalDate != null) {
                            final goalDate = DateUtilsHelper.fromDotFormat(_goalDate!);
                            final now = DateTime.now();

                            if (goalDate.isBefore(DateTime(now.year, now.month, now.day))) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('목표 날짜는 오늘 이후여야 합니다.')),
                              );
                              return;
                            }
                          }

                          final work = widget.work.copyWith(
                            designId: _selectedDesign?.id,
                            nickname: nickname,
                            customYarnInfo: customYarnInfo,
                            customNeedleInfo: customNeedleInfo,
                            goalDate: _goalDate != null ? DateUtilsHelper.fromDotFormat(_goalDate!) : null,
                            file: _image,
                            title: title,
                            designer: designer,
                          );

                          debugPrint('designId = ${_selectedDesign?.id}\n');

                          final success = await EditWorkVM.updateWork(work);
                          if (!mounted) return;

                          if (success) {
                            Navigator.pop(context); // <-- 성공 여부 반환
                          } else {
                            final error = EditWorkVM.errorMessage ?? '알 수 없는 오류';
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
                          "작품 수정하기",
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