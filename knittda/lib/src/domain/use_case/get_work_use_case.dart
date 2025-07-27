import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class GetWorkUseCase {
  final WorkRepository _repository;

  GetWorkUseCase(this._repository);

  Future<WorkModel> call(int projectId) async {
    try {
      final work = await _repository.getWork(projectId);
      return work;
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      rethrow;
    }
  }
}