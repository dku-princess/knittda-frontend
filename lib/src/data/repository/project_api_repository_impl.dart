import 'dart:async';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/project_api.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/article/article_preview.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/model/project_previews.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
  Future<Result<void>> getMyProjects() async {
    final Result<Iterable> result = await _api.getMyProjects();

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

    switch (result) {
      case Success(:final data):
        return Result.success(Project.fromJson(data));
      case Error(:final e):
        return Result.error(e);
    }
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

    switch (result) {
      case Success(:final data):
        final project = Project.fromJson(data);

        final exists = _projects.any((p) => p.id == project.id);
        if (exists) {
          _projects = _projects
              .map((p) => p.id == project.id ? project : p)
              .toList();
        }

        _projectsController.add(List.unmodifiable(_projects));
        return Result.success(project);
      case Error(:final e):
        return Result.error(e);
    }
  }

  @override
  Future<List<ArticlePreview>> getArticlePreviews({
    required List<int> ids,
  }) async {
    try {
      final data = await _api.getArticlePreviews(ids: ids);
      return data.projects;
    } on DioException catch (e, st) {
      Sentry.captureException(e, stackTrace: st);
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          throw Exception('서버 응답 시간이 초과되었습니다.');
        case DioExceptionType.connectionError:
          throw Exception('네트워크 연결을 확인해주세요.');
        case DioExceptionType.badResponse:
          throw Exception('서버 오류가 발생했습니다. (${e.response?.statusCode})');
        default:
          throw Exception('네트워크 오류가 발생했습니다.');
      }
    } catch (e, st) {
      Sentry.captureException(e, stackTrace: st);
      throw Exception('알 수 없는 오류가 발생했습니다: $e');
    }
  }
}
