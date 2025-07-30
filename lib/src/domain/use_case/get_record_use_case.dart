import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/record_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class GetRecordUseCase {
  final RecordRepository _repository;

  GetRecordUseCase(
      this._repository,
  );

  Future<RecordModel> call(int recordId) async {
    try {
      final record = await _repository.getRecord(recordId);
      return record;
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}