import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';

class GetQuestionUseCase {
  final RecordApiRepository _repository;

  GetQuestionUseCase(this._repository);

  Future<Result<String>> call({required int projectId}) async {
    final result = await _repository.getQuestion(projectId: projectId);

    return switch (result) {
      // Success(:final data) => Result.success(data),
      // Error(:final e) => Result.error(e),
      Success<String>() => Result.success(result.data),
      Error<String>() => Result.error(result.e),
    };
  }
}
