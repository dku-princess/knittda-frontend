import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class UpdateWorkUseCase {
  final WorkRepository _repository;

  UpdateWorkUseCase(this._repository);

  Future<WorkModel> call(WorkModel work) async {
    try {
      final updated = await _repository.updateWork(work);
      return updated;
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('UpdateWorkUseCase 오류: $e\n$stack');
      rethrow;
    }
  }
}