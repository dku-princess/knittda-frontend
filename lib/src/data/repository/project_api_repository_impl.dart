import 'package:knittda/src/data/data_sources/project_api.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/model/project_previews.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';

class ProjectApiRepositoryImpl implements ProjectApiRepository {
  final ProjectApi _api;

  ProjectApiRepositoryImpl(this._api);

  @override
  Future<Result<List<Project>>> getProjects() async {
    final Result<Iterable> result = await _api.getProjects();

    return switch (result) {
      Success(:final data) => Result.success(
        data.map((e) => Project.fromJson(e)).toList(),
      ),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<Result<List<ProjectPreviews>>> getProjectPreviews() async {
    final Result<Iterable> result = await _api.getProjectPreviews();

    return switch (result) {
      Success(:final data) => Result.success(
        data.map((e) => ProjectPreviews.fromJson(e)).toList(),
      ),
      Error(:final e) => Result.error(e),
    };
  }
}
