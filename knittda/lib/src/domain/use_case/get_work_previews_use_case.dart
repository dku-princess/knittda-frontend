import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/work_preview_model.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class GetWorkPreviewsUseCase {
  final WorkRepository _repository;

  GetWorkPreviewsUseCase(this._repository);

  Future<List<WorkPreviewModel>> call() async {
    try {
      final workPreviews = await _repository.getWorkPreviews();
      return workPreviews;
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('GetWorksUseCase 오류: $e\n$stack');
      rethrow;
    }
  }
}