import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/record_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class UpdateRecordUseCase {
  final RecordRepository _repository;

  UpdateRecordUseCase(
    this._repository,
  );

  Future<void> call(RecordModel record, List<int>? deleteImageIds) async {
    try {
      await _repository.updateRecord(record, deleteImageIds);
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('UpdateRecordUseCase 오류: $e\n$stack');
      rethrow;
    }
  }
}