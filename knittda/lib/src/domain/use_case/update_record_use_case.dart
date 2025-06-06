import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class UpdateRecordUseCase {
  final RecordsRepository recordsRepository;

  UpdateRecordUseCase({
    required this.recordsRepository,
  });

  Future<void> call(String accessToken, RecordModel record, List<int>? deleteImageIds) async {
    try {
      await recordsRepository.updateRecord(accessToken, record, deleteImageIds);
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('UpdateRecordUseCase 오류: $e\n$stack');
      rethrow;
    }
  }
}