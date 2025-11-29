import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_event.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_ui_event.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_view_model.dart';
import 'package:knittda/src/presentation/widgets/image_box.dart';
import 'package:provider/provider.dart';

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

      _goalDate = DateTime.tryParse(widget.project!.goalDate);
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

  Future<void> _pickGoalDate(BuildContext context) async {
    final String? startDateStr = widget.project?.startDate;

    final DateTime startDate =
        (startDateStr != null ? DateTime.tryParse(startDateStr) : null) ??
        DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _goalDate ?? startDate,
      firstDate: startDate,
      lastDate: DateTime(2100),
      helpText: '목표 날짜 선택',
    );

    if (!mounted) return;

    if (picked != null) {
      setState(() {
        _goalDate = picked;
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

    if (nickname.isEmpty || _goalDate == null || !hasImage) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('기본정보를 입력해주세요.')));
      return;
    }

    if (widget.project == null) {
      viewModel.onEvent(
        AddEditProjectEvent.saveProject(
          project: Project(
            nickname: nickname,
            startDate: DateUtilsHelper.toHyphenFormat(DateTime.now()),
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
          appBar: AppBar(
            scrolledUnderElevation: 0,
            title: Text(
              widget.project != null ? '작품 수정' : '작품 추가',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            actions: [
              //저장버튼
              TextButton(
                onPressed: viewModel.state.isLoading ? null : _saveProject,
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

            //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "기본 정보",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10),

              Row(
                children: [
                  // 대표 사진
                  GestureDetector(
                    onTap: _pickImage,
                    child:
                        (_image != null || (_thumbnailUrl?.isNotEmpty ?? false))
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
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                  ),

                  const SizedBox(width: 16),

                  //작품이름, 목표날짜
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _nicknameController,
                          maxLines: 1,
                          maxLength: 15,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "작품이름",
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),

                        TextButton(
                          onPressed: () {
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
                            _goalDate != null
                                ? DateUtilsHelper.toDotFormat(_goalDate!)
                                : "목표 날짜",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "디자인",
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
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _designTitleController,
                maxLines: 1,
                maxLength: 15,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
              SizedBox(height: 16),

              Text(
                "작가",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _designerController,
                maxLines: 1,
                maxLength: 15,
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
              SizedBox(height: 16),

              Text(
                "실",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _yarnInfoController,
                maxLines: 1,
                maxLength: 15,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
              SizedBox(height: 16),

              Text(
                "바늘",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _needleInfoController,
                maxLines: 1,
                maxLength: 15,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),

        if (viewModel.state.isLoading)
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
