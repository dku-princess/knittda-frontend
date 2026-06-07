import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project_previews.dart';
import 'package:knittda/src/domain/use_case/get_project_previews_use_case.dart';
import 'package:knittda/src/performance/initial_load_tracker.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_event.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_state.dart';

class ProjectPreviewsViewModel extends ChangeNotifier {
  final GetProjectPreviewsUseCase _getProjectPreviewsUseCase;

  bool _emittedInitialPerfT1 = false;

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
    if (!_emittedInitialPerfT1) {
      InitialLoadTracker.projectPreviews.markT1();
      _emittedInitialPerfT1 = true;
    }

    _state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    final Result<List<ProjectPreviews>> result =
        await _getProjectPreviewsUseCase();

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(projectPreviews: data);
      case Error():
        _state = state.copyWith(errorMessage: "작품을 불러오지 못했어요. 다시 시도해 주세요.");
        InitialLoadTracker.projectPreviews.abortSession();
    }
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }
}
