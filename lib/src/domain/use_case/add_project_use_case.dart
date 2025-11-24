import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';

class AddProjectUseCase {
  final ProjectApiRepository _repository;

  AddProjectUseCase(this._repository);

  Future<Result<Project>> call() async {
    final result = await _repository.postProject();

    return switch (result) {
    // Success(:final data) => Result.success(data),
    // Error(:final e) => Result.error(e),
      Success<Project>() => Result.success(result.data),
      Error<Project>() => Result.error(result.e),
    };
  }
}