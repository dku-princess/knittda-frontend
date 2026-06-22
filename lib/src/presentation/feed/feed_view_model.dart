import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/analytics_service.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/feed_pagination.dart';
import 'package:knittda/src/domain/use_case/get_feed_use_case.dart';
import 'package:knittda/src/performance/initial_load_tracker.dart';
import 'package:knittda/src/presentation/feed/feed_event.dart';
import 'package:knittda/src/presentation/feed/feed_state.dart';

class FeedViewModel extends ChangeNotifier {
  final GetFeedUseCase _getFeedUseCase;

  bool _emittedInitialPerfT1 = false;

  FeedViewModel(this._getFeedUseCase) {
    _loadFeed(0, 20, null);
  }

  FeedState _state = FeedState(
    feeds: [],
    isLoading: false,
    errorMessage: null,
    page: 0,
    hasMore: true,
    isLoadingMore: false,
  );

  FeedState get state => _state;

  Future<void> onEvent(FeedEvent event) async {
    switch (event) {
      case LoadFeed(:final page, :final size, :final sort):
        await _loadFeed(page, size, sort);
      case Refresh(:final size, :final sort):
        await _refresh(size, sort);
      case LoadNext(:final size, :final sort):
        await _loadNext(size, sort);
    }
  }

  Future<void> _loadFeed(int page, int size, List<String>? sort) async {
    if (page == 0 && !_emittedInitialPerfT1) {
      InitialLoadTracker.feed.markT1();
      _emittedInitialPerfT1 = true;
    }

    final isFirstPage = page == 0;

    if (isFirstPage) {
      _state = state.copyWith(isLoading: true, errorMessage: null);
    } else {
      if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

      _state = state.copyWith(isLoadingMore: true);
    }
    notifyListeners();

    final Result<FeedPagination> result = await _getFeedUseCase(
      page,
      size,
      sort,
    );

    switch (result) {
      case Success(:final data):
        if (!isFirstPage) {
          AnalyticsService.instance.logLoadMore('feed', page);
        }

        final updatedFeeds = isFirstPage
            ? data.content
            : [...state.feeds, ...data.content];

        _state = state.copyWith(
          feeds: updatedFeeds,
          page: page,
          hasMore: !data.last,
          errorMessage: null,
        );

      case Error():
        _state = state.copyWith(errorMessage: "피드를 불러오지 못했어요. 다시 시도해 주세요.");
        InitialLoadTracker.feed.abortSession();
    }

    if (isFirstPage) {
      _state = state.copyWith(isLoading: false);
    } else {
      _state = state.copyWith(isLoadingMore: false);
    }

    notifyListeners();
  }

  Future<void> _refresh(int size, List<String>? sort) async {
    await _loadFeed(0, size, sort);
  }

  Future<void> _loadNext(int size, List<String>? sort) async {
    await _loadFeed(state.page + 1, size, sort);
  }
}
