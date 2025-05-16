import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';

class GetRecordUseCase {
  final RecordsRepository recordsRepository;

  GetRecordUseCase({
    required this.recordsRepository,
  });

  Future<({RecordModel record})> call(String accessToken, int recordId) async {
    try {
      final result = await recordsRepository.getRecord(accessToken, recordId);
      return (record: result.record);
    } catch (e, stack) {
      debugPrint('GetRecordUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}