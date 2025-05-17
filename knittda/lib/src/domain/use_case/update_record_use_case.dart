import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';

class UpdateRecordUseCase {
  final RecordsRepository recordsRepository;

  UpdateRecordUseCase({
    required this.recordsRepository,
  });

  Future<({RecordModel record})> call(String accessToken, RecordModel record) async {
    try {
      final result = await recordsRepository.updateRecord(accessToken, record);
      return (record: result.record);
    } catch (e, stack) {
      debugPrint('UpdateRecordUseCase 오류: $e\n$stack');
      rethrow;
    }
  }
}