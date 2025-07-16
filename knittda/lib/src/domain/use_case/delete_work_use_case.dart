import 'package:flutter/material.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class DeleteWorkUseCase {
  final WorkRepository _repository;

  DeleteWorkUseCase(this._repository);

  Future<void> call(int projectId) async {
    try {
      await _repository.deleteWork(projectId);
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('DeleteWorkUseCase 오류: $e\n$stack');
      rethrow;
    }
  }
}