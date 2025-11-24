import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';

class GetProjectsUseCase {
  final ProjectApiRepository _repository;

  GetProjectsUseCase(this._repository);

  Future<Result<List<Project>>> call() async {
    final result = await _repository.getProjects();

    return switch (result) {
      //Success(:final data) => Result.success(data),
      //Error(:final e) => Result.error(e),
      Success<List<Project>>() => Result.success(result.data),
      Error<List<Project>>() => Result.error(result.e),
    };
  }
}