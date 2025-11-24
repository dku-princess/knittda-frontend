import 'package:flutter/cupertino.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/use_case/get_projects_use_case.dart';
import 'package:knittda/src/domain/util/project_order.dart';
import 'package:knittda/src/presentation/projects/projects_event.dart';
import 'package:knittda/src/presentation/projects/projects_state.dart';

class ProjectsViewModel extends ChangeNotifier {
  final GetProjectsUseCase _getProjectsUseCase;

  ProjectsViewModel(this._getProjectsUseCase) {
    _loadProjects();
  }

  ProjectsState _state = ProjectsState(
    [],
    false,
    null,
    ProjectOrder.inProgress(),
  );

  ProjectsState get state => _state;

  Future<void> onEvent(ProjectsEvent event) async {
    switch (event) {
      case LoadProjects():
        await _loadProjects();
      case ChangeOrder(:final projectOrder):
        _state = state.copyWith(projectOrder: projectOrder);
        _loadProjects();
    }
  }

  Future<void> _loadProjects() async {
    _state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    final Result<List<Project>> result = await _getProjectsUseCase(
      state.projectOrder,
    );

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(projects: data);
      case Error(:final e):
        _state = state.copyWith(errorMessage: e);
    }
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }
}
