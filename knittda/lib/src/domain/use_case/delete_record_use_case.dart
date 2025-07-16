import 'package:flutter/material.dart';
import 'package:knittda/src/data/repositories/record_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class DeleteRecordUseCase {
  final RecordRepository _repository;

  DeleteRecordUseCase(
    this._repository,
  );

  Future<void> call(int recordId) async {
    try {
      await _repository.deleteRecord(recordId);
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('DeleteRecordUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}