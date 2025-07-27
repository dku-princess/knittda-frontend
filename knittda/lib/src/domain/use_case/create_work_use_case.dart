import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CreateWorkUseCase {
  final WorkRepository _repository;

  CreateWorkUseCase(this._repository);

  Future<WorkModel> call(WorkModel work) async {
    try {
      final created = await _repository.createWork(work);
      return created;
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      rethrow;
    }
  }
}