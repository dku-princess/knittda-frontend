import 'package:flutter/material.dart';
//import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class GetRecordsUseCase {
  final RecordsRepository recordsRepository;

  GetRecordsUseCase({
    required this.recordsRepository,
  });

  Future<void> call(String accessToken, int projectId) async {
    try {
      await recordsRepository.getRecords(accessToken, projectId);
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('GetRecordUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}