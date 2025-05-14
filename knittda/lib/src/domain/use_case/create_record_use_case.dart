import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/records_model.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';

class CreateRecordUseCase {
final RecordsRepository recordsRepository;

CreateRecordUseCase({
  required this.recordsRepository,
});

Future<({RecordsModel record})> call(String accessToken, RecordsModel record) async {
  try {
    final result = await recordsRepository.createRecord(accessToken, record);
    return (record: result.record); // record 반환 구조 주의!
  } catch (e, stack) {
    debugPrint('CreateRecordUseCase 오류: $e\n$stack');
    rethrow; // 호출 측에서 catch 가능하게 재던짐
  }
 }
}