import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/feed_pagination.dart';
import 'package:knittda/src/domain/use_case/get_search_feed_use_case.dart';
import 'package:knittda/src/presentation/feed_search/feed_search_event.dart';
import 'package:knittda/src/presentation/feed_search/feed_search_state.dart';
import 'package:knittda/src/presentation/feed_search/feed_search_ui_event.dart';

class FeedSearchViewModel extends ChangeNotifier {
  final GetSearchFeedUseCase _getSearchFeedUseCase;

  FeedSearchViewModel(this._getSearchFeedUseCase);

  FeedSearchState _state = FeedSearchState(
    feeds: [],
    isLoading: false,
    keyword: '',
    page: 0,
    hasMore: true,
    isLoadingMore: false,
  );

  FeedSearchState get state => _state;

  final _eventController = StreamController<FeedSearchUiEvent>();

  Stream<FeedSearchUiEvent> get eventStream => _eventController.stream;

  Future<void> onEvent(FeedSearchEvent event) async {
    switch (event) {
      case SearchFeed(:final keyword, :final page, :final size, :final sort):
        await _searchFeed(keyword, page, size, sort);
      case LoadNext(:final size, :final sort):
        await _loadNext(size, sort);
      case Clear():
        _clear();
    }
  }

  Future<void> _searchFeed(
    String keyword,
    int page,
    int size,
    List<String>? sort,
  ) async {
    if (keyword.isEmpty) {
      _eventController.add(
        const FeedSearchUiEvent.showSnackBar('검색어를 입력해 주세요'),
      );
      return;
    }

    final isFirstPage = page == 0;

    if (state.isLoading || state.isLoadingMore) {
      return;
    }

    if (!isFirstPage && !state.hasMore) {
      return;
    }

    if (isFirstPage) {
      _state = state.copyWith(isLoading: true);
    } else {
      _state = state.copyWith(isLoadingMore: true);
    }
    notifyListeners();

    final Result<FeedPagination> result = await _getSearchFeedUseCase(
      keyword,
      page,
      size,
      sort,
    );

    switch (result) {
      case Success(:final data):
        final updatedFeeds = isFirstPage
            ? data.content
            : [...state.feeds, ...data.content];

        _state = state.copyWith(
          feeds: updatedFeeds,
          keyword: keyword,
          page: page,
          hasMore: !data.last,
        );

      case Error():
        _eventController.add(FeedSearchUiEvent.showSnackBar("피드를 불러오지 못했어요. 다시 시도해 주세요."));
    }

    if (isFirstPage) {
      _state = state.copyWith(isLoading: false);
    } else {
      _state = state.copyWith(isLoadingMore: false);
    }

    notifyListeners();
  }

  Future<void> _loadNext(int size, List<String>? sort) async {
    await _searchFeed(state.keyword, state.page + 1, size, sort);
  }

  void _clear() {
    _state = state.copyWith(feeds: [], keyword: '', page: 0, hasMore: true);
    notifyListeners();
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}
