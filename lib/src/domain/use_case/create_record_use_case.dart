import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/record_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CreateRecordUseCase {
  final RecordRepository _repository;

  CreateRecordUseCase(
    this._repository,
  );

  Future<RecordModel> call(RecordModel record) async {
    try {
      final created = await _repository.createRecord(record);
      return created;
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      //debugPrint('CreateRecordUseCase 오류: $e\n$stack');
      rethrow;
    }
  }
}