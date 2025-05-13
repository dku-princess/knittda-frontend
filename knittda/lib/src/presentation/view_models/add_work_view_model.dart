import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/design_model.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/presentation/screens/home.dart';
import 'work_view_model.dart';
import 'package:knittda/src/core/utils/date_utils.dart';

class AddWorkViewModel extends ChangeNotifier {
  DesignModel? _design;
  DesignModel? get design => _design;

  final WorkViewModel _workViewModel;
  final formKey = GlobalKey<FormState>();

  final nicknameController = TextEditingController();
  final designController = TextEditingController();
  final designerController = TextEditingController();
  final yarnController = TextEditingController();
  final needleController = TextEditingController();

  String? startDate;
  String? endDate;
  String? goalDate;

  void setDesign(DesignModel design){
    _design = design;
    designController.text = design.title ?? '';
    designerController.text = design.designer ?? '';
    notifyListeners();
  }

  AddWorkViewModel(this._workViewModel) {
    final today = DateTime.now();
    startDate = DateUtilsHelper.toDotFormat(today);
  }

  @override
  void dispose() {
    nicknameController.dispose();
    yarnController.dispose();
    needleController.dispose();
    super.dispose();
  }

  Future<void> pickGoalDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: '목표 날짜 선택',
    );

    if (picked != null) {
      goalDate = DateUtilsHelper.toDotFormat(picked);
      endDate = DateUtilsHelper.toDotFormat(picked);
      notifyListeners();
    }
  }

  void onSavePressed(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      // Save text values
      final nickname = nicknameController.text;
      final customYarnInfo = yarnController.text;
      final customNeedleInfo = needleController.text;

      final work = WorkModel.forCreate(
        designId: 1,
        nickname: nickname,
        customYarnInfo: customYarnInfo,
        customNeedleInfo: customNeedleInfo,
        startDate: DateUtilsHelper.fromDotFormat(startDate!),
        endDate: DateUtilsHelper.fromDotFormat(endDate!),
        goalDate: DateUtilsHelper.fromDotFormat(goalDate!),
      );

      await _workViewModel.createWork(work: work);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const Home()),
            (route) => false,
      );
    }
  }

  String? nicknameValidator(String? val) {
    if (val == null || val.isEmpty) return '작품이름을 입력해주세요';
    return null;
  }

  String? yarnValidator(String? val) {
    if (val == null || val.isEmpty) return '실 정보를 입력해주세요';
    return null;
  }

  String? needleValidator(String? val) {
    if (val == null || val.isEmpty) return '바늘 정보를 입력해주세요';
    return null;
  }

  String? goalDateValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '날짜를 선택해주세요';
    }

    try {
      final goal = DateUtilsHelper.fromDotFormat(val);
      final start = DateUtilsHelper.fromDotFormat(startDate!);
      if (goal.isBefore(start)) {
        return '목표 날짜는 시작 날짜 이후여야 합니다';
      }
    } catch (e) {
      return '유효하지 않은 날짜 형식입니다';
    }

    return null;
  }
}