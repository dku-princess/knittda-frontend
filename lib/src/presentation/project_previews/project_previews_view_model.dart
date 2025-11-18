import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project_previews.dart';
import 'package:knittda/src/domain/use_case/get_project_previews_use_case.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_event.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_state.dart';

class ProjectPreviewsViewModel extends ChangeNotifier {
  final GetProjectPreviewsUseCase _getProjectPreviewsUseCase;

  ProjectPreviewsViewModel(this._getProjectPreviewsUseCase) {
    _loadProjectPreviews();
  }

  ProjectPreviewsState _state = ProjectPreviewsState([], false, null);

  ProjectPreviewsState get state => _state;

  Future<void> onEvent(ProjectPreviewsEvent event) async {
    switch (event) {
      case LoadProjectPreviews():
        await _loadProjectPreviews();
    }
  }

  Future<void> _loadProjectPreviews() async {
    _state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    final Result<List<ProjectPreviews>> result =
        await _getProjectPreviewsUseCase();

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(projectPreviews: data);
      case Error(:final e):
        _state = state.copyWith(errorMessage: e);
    }
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }
}
