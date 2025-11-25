import 'package:image_picker/image_picker.dart';
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
  Future<Result<Project>> postProject({
    required Project project,
    required XFile? file,
  }) async {
    final Result<Map<String, dynamic>> result = await _api.postProject(
      project: project,
      file: file,
    );

    return switch (result) {
      Success(:final data) => Result.success(Project.fromJson(data)),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<Result<Project>> putProject({
    required Project project,
    required XFile? file,
  }) async {
    final Result<Map<String, dynamic>> result = await _api.putProject(
      project: project,
      file: file,
    );

    return switch (result) {
      Success(:final data) => Result.success(Project.fromJson(data)),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<Result<Project>> getProject({required int projectId}) async {
    final Result<Map<String, dynamic>> result = await _api.getProject(
      projectId: projectId,
    );

    return switch (result) {
      Success(:final data) => Result.success(Project.fromJson(data)),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<Result<void>> deleteProject({required int projectId}) async {
    final Result<void> result = await _api.deleteProject(projectId: projectId);

    return switch (result) {
      Success() => Result.success(null),
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

  @override
  Future<Result<Project>> getMyProject({required int projectId}) async {
    final Result<Map<String, dynamic>> result = await _api.getMyProject(
      projectId: projectId,
    );

    return switch (result) {
      Success(:final data) => Result.success(Project.fromJson(data)),
      Error(:final e) => Result.error(e),
    };
  }
}
