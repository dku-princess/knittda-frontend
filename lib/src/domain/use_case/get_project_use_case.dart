import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';

class GetProjectUseCase {
  final ProjectApiRepository _repository;

  GetProjectUseCase(this._repository);

  Future<Result<Project>> call({required int projectId}) async {
    final result = await _repository.getProject(projectId: projectId);

    return switch (result) {
      Success<Project>() => Result.success(result.data),
      Error<Project>() => Result.error(result.e),
    };
  }
}