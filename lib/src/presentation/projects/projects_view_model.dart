import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/use_case/get_projects_use_case.dart';
import 'package:knittda/src/domain/util/project_order.dart';
import 'package:knittda/src/presentation/projects/projects_event.dart';
import 'package:knittda/src/presentation/projects/projects_state.dart';

class ProjectsViewModel extends ChangeNotifier {
  final ProjectApiRepository _repository;
  final GetProjectsUseCase _getProjectsUseCase;

  StreamSubscription<List<Project>>? _subscription;

  ProjectsState _state = ProjectsState(
    [],
    false,
    null,
    ProjectOrder.inProgress(),
  );

  ProjectsState get state => _state;

  ProjectsViewModel(this._repository, this._getProjectsUseCase) {
    _subscription = _repository.projectsStream.listen(
      (_) {
        _orderProjects();
      },
      onError: (e) {
        _state = state.copyWith(errorMessage: "작품 목록을 불러오지 못했어요.");
        notifyListeners();
      },
    );
    _fetchProjects();
  }

  Future<void> onEvent(ProjectsEvent event) async {
    switch (event) {
      case LoadProjects():
        await _fetchProjects();
      case ChangeOrder(:final projectOrder):
        _state = state.copyWith(projectOrder: projectOrder);
        _orderProjects();
    }
  }

  Future<void> _fetchProjects() async {
    _state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    final Result<void> result = await _repository.fetchProjects();

    switch (result) {
      case Success():
        _state = state.copyWith(isLoading: false);
      case Error():
        _state = state.copyWith(isLoading: false, errorMessage: "작품 목록을 불러오지 못했어요.");
    }

    notifyListeners();
  }

  void _orderProjects() {
    _state = state.copyWith(errorMessage: null);

    final Result<List<Project>> result = _getProjectsUseCase(
      state.projectOrder,
    );

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(projects: data);
      case Error():
        _state = state.copyWith(errorMessage: "작품 목록을 불러오지 못했어요.");
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
