import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project_previews_page.dart';
import 'package:knittda/src/domain/use_case/get_project_previews_use_case.dart';
import 'package:knittda/src/performance/initial_load_tracker.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_event.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_state.dart';

class ProjectPreviewsViewModel extends ChangeNotifier {
  final GetProjectPreviewsUseCase _getProjectPreviewsUseCase;

  bool _emittedInitialPerfT1 = false;

  ProjectPreviewsViewModel(this._getProjectPreviewsUseCase) {
    _loadFirstPage();
  }

  ProjectPreviewsState _state = ProjectPreviewsState([], false, null);

  ProjectPreviewsState get state => _state;

  Future<void> onEvent(ProjectPreviewsEvent event) async {
    switch (event) {
      case LoadProjectPreviews():
        await _loadFirstPage();
      case LoadMore():
        await _loadMore();
    }
  }

  Future<void> _loadFirstPage() async {
    if (!_emittedInitialPerfT1) {
      InitialLoadTracker.projectPreviews.markT1();
      _emittedInitialPerfT1 = true;
    }

    _state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    final Result<ProjectPreviewsPage> result =
        await _getProjectPreviewsUseCase(page: 0);

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(
          projectPreviews: data.content,
          currentPage: data.number,
          hasMore: !data.last,
        );
      case Error():
        _state = state.copyWith(errorMessage: "작품을 불러오지 못했어요. 다시 시도해 주세요.");
        InitialLoadTracker.projectPreviews.abortSession();
    }
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> _loadMore() async {
    if (_state.isLoading || _state.isLoadingMore || !_state.hasMore) return;

    _state = state.copyWith(isLoadingMore: true);
    notifyListeners();

    final nextPage = _state.currentPage + 1;
    final Result<ProjectPreviewsPage> result =
        await _getProjectPreviewsUseCase(page: nextPage);

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(
          projectPreviews: [..._state.projectPreviews, ...data.content],
          currentPage: data.number,
          hasMore: !data.last,
        );
      case Error():
        break;
    }
    _state = state.copyWith(isLoadingMore: false);
    notifyListeners();
  }
}
