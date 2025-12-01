import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/project_api.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/model/project_previews.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';

class ProjectApiRepositoryImpl implements ProjectApiRepository {
  final ProjectApi _api;

  ProjectApiRepositoryImpl(this._api);

  final _projectsController = StreamController<List<Project>>.broadcast();
  List<Project> _projects = [];

  @override
  Stream<List<Project>> get projectsStream => _projectsController.stream;

  @override
  List<Project> get currentProjects => List.unmodifiable(_projects);

  @override
  Future<Result<void>> fetchProjects() async {
    final Result<Iterable> result = await _api.getProjects();

    switch (result) {
      case Success(:final data):
        _projects = data.map((e) => Project.fromJson(e)).toList();
        _projectsController.add(List.unmodifiable(_projects));
        return Result.success(null);

      case Error(:final e):
        return Result.error(e);
    }
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

    switch (result) {
      case Success(:final data):
        final created = Project.fromJson(data);
        _projects = [..._projects, created];
        _projectsController.add(List.unmodifiable(_projects));
        return Result.success(created);

      case Error(:final e):
        return Result.error(e);
    }
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

    switch (result) {
      case Success(:final data):
        final updated = Project.fromJson(data);
        _projects = _projects
            .map((p) => p.id == updated.id ? updated : p)
            .toList();
        _projectsController.add(List.unmodifiable(_projects));
        return Result.success(updated);

      case Error(:final e):
        return Result.error(e);
    }
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

    switch (result) {
      case Success():
        _projects = _projects.where((p) => p.id != projectId).toList();
          _projectsController.add(List.unmodifiable(_projects));
          return Result.success(null);

      case Error(:final e):
        return Result.error(e);
    }
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
