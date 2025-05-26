import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/data/repositories/work_repositories.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CreateWorkUseCase {
  final WorkRepositories workRepositories;

  CreateWorkUseCase({
    required this.workRepositories,
  });

  Future<({WorkModel work})> call(String accessToken, WorkModel work) async {
    try {
      final result = await workRepositories.createWork(accessToken, work);
      return (work: result.work); // record 반환 구조 주의!
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('CreateWorkUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}