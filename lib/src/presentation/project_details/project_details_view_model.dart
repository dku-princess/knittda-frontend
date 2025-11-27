import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/use_case/delete_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_my_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_project_use_case.dart';
import 'package:knittda/src/domain/use_case/update_project_use_case.dart';
import 'package:knittda/src/presentation/project_details/project_details_event.dart';
import 'package:knittda/src/presentation/project_details/project_details_state.dart';
import 'package:knittda/src/presentation/project_details/project_details_ui_event.dart';

class ProjectDetailsViewModel extends ChangeNotifier {
  final GetProjectUseCase _getProjectUseCase;
  final GetMyProjectUseCase _getMyProjectUseCase;
  final DeleteProjectUseCase _deleteProjectUseCase;
  final UpdateProjectUseCase _updateProjectUseCase;

  ProjectDetailsState _state = ProjectDetailsState(
    project: null,
    isLoading: false,
  );

  ProjectDetailsState get state => _state;

  final _eventController = StreamController<ProjectDetailsUiEvent>();

  Stream<ProjectDetailsUiEvent> get eventStream => _eventController.stream;

  ProjectDetailsViewModel(
    this._getProjectUseCase,
    this._getMyProjectUseCase,
    this._deleteProjectUseCase,
    this._updateProjectUseCase, {
    required int projectId,
    Project? project,
  }) {
    _loadProject(projectId: projectId, project: project);
  }

  Future<void> onEvent(ProjectDetailsEvent event) async {
    switch (event) {
      case LoadProject(:final projectId, :final project):
        await _loadProject(projectId: projectId, project: project);
      case DeleteProject(:final projectId):
        await _deleteProject(projectId: projectId);
    }
  }

  Future<void> _loadProject({required int projectId, Project? project}) async {
    //project가 있으면 그걸 먼저 보여주고, 서버에 있는 정보 가져오기,
    if (project != null) {
      _state = state.copyWith(project: project);
      notifyListeners();

      final Result<Project> result = await _getMyProjectUseCase(
        projectId: projectId,
      );

      switch (result) {
        case Success(:final data):
          _state = state.copyWith(project: data);
        case Error(:final e):
          _eventController.add(ProjectDetailsUiEvent.showSnackBar(e));
      }

      notifyListeners();
    } else {
      _state = state.copyWith(isLoading: true);
      notifyListeners();

      final Result<Project> result = await _getProjectUseCase(
        projectId: projectId,
      );

      switch (result) {
        case Success(:final data):
          _state = state.copyWith(project: data);
        case Error(:final e):
          _eventController.add(ProjectDetailsUiEvent.showSnackBar(e));
      }

      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> _deleteProject({required int projectId}) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final Result<void> result = await _deleteProjectUseCase(
      projectId: projectId,
    );

    switch (result) {
      case Success():
        _eventController.add(ProjectDetailsUiEvent.deletedProject());
      case Error(:final e):
        _eventController.add(ProjectDetailsUiEvent.showSnackBar(e));
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}
