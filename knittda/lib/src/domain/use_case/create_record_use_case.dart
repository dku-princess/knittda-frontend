import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/record_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CreateRecordUseCase {
  final RecordRepository _repository;

  CreateRecordUseCase(
    this._repository,
  );

  Future<void> call(RecordModel record) async {
    try {
      await _repository.createRecord(record);
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('CreateRecordUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}