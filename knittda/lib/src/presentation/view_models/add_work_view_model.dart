import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/presentation/screens/home.dart';
import 'package:provider/provider.dart';
import 'work_view_model.dart';

class AddWorkViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  String? nickname;
  String? startDate;
  String? endDate;
  String? goalDate;
  String? customYarnInfo;
  String? customNeedleInfo;

  AddWorkViewModel() {
    startDate = _formatDate(DateTime.now());
  }

  String _formatDate(DateTime date) {
    return "${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}";
  }

  DateTime _parseDotDate(String date) {
    final parts = date.split('.');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
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
      goalDate = _formatDate(picked);
      endDate = _formatDate(picked);
      notifyListeners();
    }
  }

  void onSavePressed(BuildContext context) async {
      if (formKey.currentState!.validate()) {
      // ➊ 폼 검증하기
      formKey.currentState!.save(); // ➋ 폼 저장하기

      final work = WorkModel.forCreate(
        nickname: nickname!,
        customYarnInfo: customYarnInfo!,
        customNeedleInfo: customNeedleInfo!,
        startDate: _parseDotDate(startDate!),
        endDate: _parseDotDate(endDate!),
        goalDate: _parseDotDate(goalDate!),
      );

      await context.read<WorkViewModel>().createWork(work: work);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const Home()),
            (route) => false,
      );
    }
  }

  String? nicknameValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '작품이름을 입력해주세요';
    }

    return null;
  }

  String? goalDateValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '날짜를 선택해주세요';
    }

    try {
      final goal = DateTime.parse(val.replaceAll('.', '-'));
      final start = DateTime.parse(startDate!.replaceAll('.', '-'));

      if (goal.isBefore(start)) {
        return '목표 날짜는 시작 날짜 이후여야 합니다';
      }
    } catch (e) {
      return '유효하지 않은 날짜 형식입니다';
    }

    return null;
  }

  String? yarnValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '실 정보를 입력해주세요';
    }

    return null;
  }

  String? needleValidator(String? val) {
    if (val == null || val.isEmpty) {
      return '바늘 정보를 입력해주세요';
    }

    return null;
  }

}