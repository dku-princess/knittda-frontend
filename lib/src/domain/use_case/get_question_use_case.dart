import 'package:knittda/src/data/repositories/record_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class GetQuestionUseCase {
  final RecordRepository _repository;

  GetQuestionUseCase(
      this._repository,
      );

  Future<String> call(int projectId) async {
    try {
      final question = await _repository.getQuestion(projectId);
      return question;
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      rethrow;
    }
  }
}