import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/data_sources/analytics_service.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:knittda/src/domain/use_case/delete_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_my_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_user_use_case.dart';
import 'package:knittda/src/domain/use_case/update_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_records_projects_use_case.dart';
import 'package:knittda/src/presentation/project_details/diary_tap_state.dart';
import 'package:knittda/src/presentation/project_details/project_details_event.dart';
import 'package:knittda/src/presentation/project_details/project_details_state.dart';
import 'package:knittda/src/presentation/project_details/project_details_ui_event.dart';

class ProjectDetailsViewModel extends ChangeNotifier {
  final GetProjectUseCase _getProjectUseCase;
  final GetMyProjectUseCase _getMyProjectUseCase;
  final DeleteProjectUseCase _deleteProjectUseCase;
  final UpdateProjectUseCase _updateProjectUseCase;
  final GetRecordsProjectsUseCase _getRecordsProjectsUseCase;
  final GetUserUseCase _getUserUseCase;
  StreamSubscription? _streamSubscription;

  ProjectDetailsState _state = ProjectDetailsState(
    project: null,
    isLoading: false,
    isOwner: false,
    user: null,
    diaryTapState: DiaryTapState(
      records: [],
      isLoading: false,
      errorMessage: null,
    ),
  );

  ProjectDetailsState get state => _state;

  final _eventController = StreamController<ProjectDetailsUiEvent>();

  Stream<ProjectDetailsUiEvent> get eventStream => _eventController.stream;

  /// 작품 상세 진입 경로(GA4 source 파라미터).
  /// 예: project_list / article_detail / feed / feed_search / project_previews
  final String source;

  ProjectDetailsViewModel(
    this._getProjectUseCase,
    this._getMyProjectUseCase,
    this._deleteProjectUseCase,
    this._updateProjectUseCase,
    this._getRecordsProjectsUseCase,
    this._getUserUseCase, {
    required int projectId,
    Project? project,
    this.source = 'unknown',
  }) {
    _loadUser();
    _loadProject(projectId: projectId, project: project);
    _loadRecords(projectId: projectId);
  }

  Future<void> onEvent(ProjectDetailsEvent event) async {
    switch (event) {
      case LoadProject(:final projectId, :final project):
        await _loadProject(projectId: projectId, project: project);
      case DeleteProject(:final projectId):
        await _deleteProject(projectId: projectId);
      case ChangeProgress():
        await _changeProgress();
      case LoadRecords(:final projectId):
        await _loadRecords(projectId: projectId);
    }
  }

  void _updateIsOwner() {
    final user = state.user;
    final project = state.project;

    final isOwner =
        user != null && project != null && user.id == project.userId;

    _state = state.copyWith(isOwner: isOwner);
  }

  void _loadUser() {
    _streamSubscription = _getUserUseCase.execute().listen((user) {
      _state = state.copyWith(user: user);
      _updateIsOwner();
      notifyListeners();
    });
  }

  Future<void> _loadProject({required int projectId, Project? project}) async {
    //project가 있으면 그걸 먼저 보여주고, 서버에 있는 정보 가져오기,
    if (project != null) {
      _state = state.copyWith(project: project);
      _updateIsOwner();
      notifyListeners();

      final Result<Project> result = await _getMyProjectUseCase(
        projectId: projectId,
      );

      switch (result) {
        case Success(:final data):
          _state = state.copyWith(project: data);
          AnalyticsService.instance.logViewProject(
            projectId.toString(),
            source: source,
          );
        case Error():
          _eventController.add(
            ProjectDetailsUiEvent.showSnackBar("작품을 불러오지 못했어요. 다시 시도해 주세요."),
          );
      }

      _updateIsOwner();
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
          AnalyticsService.instance.logViewProject(
            projectId.toString(),
            source: source,
          );
        case Error():
          _eventController.add(
            ProjectDetailsUiEvent.showSnackBar("삭제되었거나 존재하지 않는 작품이에요."),
          );
          _eventController.add(ProjectDetailsUiEvent.notFound());
      }

      _updateIsOwner();
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> _deleteProject({required int projectId}) async {
    if (!state.isOwner) return;

    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final Result<void> result = await _deleteProjectUseCase(
      projectId: projectId,
    );

    switch (result) {
      case Success():
        AnalyticsService.instance.logDeleteProject(projectId.toString());
        _eventController.add(ProjectDetailsUiEvent.deletedProject());
      case Error():
        _eventController.add(
          ProjectDetailsUiEvent.showSnackBar("작품을 삭제하지 못했어요. 다시 시도해 주세요."),
        );
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> _changeProgress() async {
    if (!state.isOwner) return;

    final project = state.project;
    if (project == null || project.id == null) return;

    final newStatus = switch (project.status) {
      "IN_PROGRESS" => "DONE",
      "DONE" => "IN_PROGRESS",
      _ => project.status,
    };

    final updatedProject = project.copyWith(
      projectId: project.id,
      status: newStatus,
      endDate: newStatus == 'DONE'
          ? DateUtilsHelper.toHyphenFormat(DateTime.now())
          : null,
    );

    final prevProject = project;

    _state = state.copyWith(project: updatedProject);
    notifyListeners();

    final result = await _updateProjectUseCase(
      project: updatedProject,
      file: null,
    );

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(project: data);
      case Error():
        _state = state.copyWith(project: prevProject);
        _eventController.add(
          ProjectDetailsUiEvent.showSnackBar("작품의 상태를 변경하지 못했어요. 다시 시도해 주세요."),
        );
    }

    notifyListeners();
  }

  Future<void> _loadRecords({required int projectId}) async {
    _state = state.copyWith(
      diaryTapState: state.diaryTapState.copyWith(
        isLoading: true,
        errorMessage: null,
      ),
    );
    notifyListeners();

    final Result<List<Records>> result = await _getRecordsProjectsUseCase(
      projectId: projectId,
    );

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(
          diaryTapState: state.diaryTapState.copyWith(records: data),
        );
      case Error():
        _state = state.copyWith(
          diaryTapState: state.diaryTapState.copyWith(
            errorMessage: "기록을 불러오지 못했어요.",
          ),
        );
        _eventController.add(
          ProjectDetailsUiEvent.showSnackBar("기록을 불러오지 못했어요."),
        );
    }

    _state = state.copyWith(
      diaryTapState: state.diaryTapState.copyWith(isLoading: false),
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _eventController.close();
    super.dispose();
  }
}
