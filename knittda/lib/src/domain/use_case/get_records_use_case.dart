import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/record_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class GetRecordsUseCase {
  final RecordRepository _repository;

  GetRecordsUseCase(
    this._repository,
  );

  Future<List<RecordModel>> call(int projectId) async {
    try {
      final records = await _repository.getRecords(projectId);
      return records;
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('GetRecordUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}