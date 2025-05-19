import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CreateRecordUseCase {
  final RecordsRepository recordsRepository;

  CreateRecordUseCase({
    required this.recordsRepository,
  });

  Future<({RecordModel record})> call(String accessToken, RecordModel record) async {
    try {
      final result = await recordsRepository.createRecord(accessToken, record);
      return (record: result.record); // record 반환 구조 주의!
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('CreateRecordUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}