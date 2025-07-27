import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/data/repositories/record_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class UpdateRecordUseCase {
  final RecordRepository _repository;

  UpdateRecordUseCase(
    this._repository,
  );

  Future<RecordModel> call(RecordModel record, List<int>? deleteImageIds) async {
    try {
      final updated = await _repository.updateRecord(record, deleteImageIds);
      return updated;
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      rethrow;
    }
  }
}