import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/util/project_order.dart';

class OrderProjectsUseCase {
  final ProjectApiRepository _repository;

  OrderProjectsUseCase(this._repository);

  Result<List<Project>> call(ProjectOrder projectOrder) {
    final projects = _repository.currentProjects;

    return switch (projectOrder) {
      InProgress() => Result.success(
        projects.where((p) => p.status == "IN_PROGRESS").toList(),
      ),
      Done() => Result.success(
        projects.where((p) => p.status == "DONE").toList(),
      ),
    };
  }
}