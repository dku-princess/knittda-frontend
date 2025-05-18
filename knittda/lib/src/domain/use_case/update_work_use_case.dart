import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/data/repositories/work_repositories.dart';

class UpdateWorkUseCase {
  final WorkRepositories workRepositories;

  UpdateWorkUseCase({
    required this.workRepositories,
  });

  Future<({WorkModel work})> call(String accessToken, WorkModel work) async {
    try {
      final result = await workRepositories.updateWork(accessToken, work);
      return (work: result.work);
    } catch (e, stack) {
      debugPrint('UpdateWorkUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}