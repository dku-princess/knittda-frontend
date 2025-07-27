import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class GetWorksUseCase {
  final WorkRepository _repository;

  GetWorksUseCase(this._repository);

  Future<List<WorkModel>> call() async {
    try {
      final works = await _repository.getWorks();
      return works;
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      rethrow;
    }
  }
}