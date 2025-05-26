import 'package:flutter/material.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class DeleteRecordUseCase {
  final RecordsRepository recordsRepository;

  DeleteRecordUseCase({
    required this.recordsRepository,
  });

  Future<void> call(String accessToken, int recordId) async {
    try {
      await recordsRepository.deleteRecord(accessToken, recordId);
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('DeleteRecordUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}