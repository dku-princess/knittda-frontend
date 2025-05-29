import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class UpdateWorkUseCase {
  final WorkRepository workRepository;

  UpdateWorkUseCase({
    required this.workRepository,
  });

  Future<void> call(String accessToken, WorkModel work) async {
    try {
      await workRepository.updateWork(accessToken, work);
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('UpdateWorkUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}