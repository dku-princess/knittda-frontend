import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/util/project_order.dart';

class GetProjectsUseCase {
  final ProjectApiRepository _repository;

  GetProjectsUseCase(this._repository);

  Future<Result<List<Project>>> call(ProjectOrder projectOrder) async {
    final result = await _repository.getProjects();

    return switch (result) {
      Success(:final data) => _filterProjects(data, projectOrder),
      Error(:final e) => Result.error(e),
      //Success<List<Project>>() => Result.success(result.data),
      //Error<List<Project>>() => Result.error(result.e),
    };
  }

  Result<List<Project>> _filterProjects(
    List<Project> projects,
    ProjectOrder order,
  ) {
    return switch (order) {
      InProgress() => Result.success(
        projects.where((p) => p.status == "IN_PROGRESS").toList(),
      ),

      Done() => Result.success(
        projects.where((p) => p.status == "DONE").toList(),
      ),
    };
  }

}
