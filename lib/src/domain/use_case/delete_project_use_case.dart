import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';

class DeleteProjectUseCase {
  final ProjectApiRepository _repository;

  DeleteProjectUseCase(this._repository);

  Future<Result<void>> call({required int projectId}) async {
    final result = await _repository.deleteProject(projectId: projectId);

    return switch (result) {
      Success<void>() => Result.success(null),
      Error<void>() => Result.error(result.e),
    };
  }
}