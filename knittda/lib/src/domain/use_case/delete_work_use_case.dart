import 'package:flutter/material.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class DeleteWorkUseCase {
  final WorkRepository workRepository;

  DeleteWorkUseCase({
    required this.workRepository,
  });

  Future<void> call(String accessToken, int projectId) async {
    try {
      await workRepository.deleteWork(accessToken, projectId);
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('DeleteWorkUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}