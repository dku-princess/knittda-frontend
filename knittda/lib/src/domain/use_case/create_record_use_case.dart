import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CreateRecordUseCase {
  final RecordsRepository recordsRepository;

  CreateRecordUseCase({
    required this.recordsRepository,
  });

  Future<void> call(String accessToken, RecordModel record) async {
    try {
      await recordsRepository.createRecord(accessToken, record);
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('CreateRecordUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}