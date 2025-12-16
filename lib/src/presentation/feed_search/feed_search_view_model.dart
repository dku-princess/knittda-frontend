import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/feed_pagination.dart';
import 'package:knittda/src/domain/repository/feed_api_repository.dart';
import 'package:knittda/src/domain/use_case/get_search_feed_use_case.dart';
import 'package:knittda/src/presentation/feed_search/feed_search_event.dart';
import 'package:knittda/src/presentation/feed_search/feed_search_state.dart';
import 'package:knittda/src/presentation/feed_search/feed_search_ui_event.dart';

class FeedSearchViewModel extends ChangeNotifier {
  final GetSearchFeedUseCase _getSearchFeedUseCase;
  final FeedApiRepository _feedApiRepository;

  FeedSearchViewModel(
    this._getSearchFeedUseCase,
    this._feedApiRepository,
  );

  FeedSearchState _state = FeedSearchState(
    feeds: [],
    isLoading: false,
    keyword: '',
    page: 0,
    hasMore: true,
    isLoadingMore: false,
    searchId: null,
    searchVersion: null,
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
        // 디버깅: 파싱된 데이터 확인
        print('[FeedSearchViewModel] Search result:');
        print('  - content length: ${data.content.length}');
        print('  - searchId: ${data.searchId}');
        print('  - searchVersion: ${data.searchVersion}');
        print('  - last: ${data.last}');
        print('  - empty: ${data.empty}');
        
        final updatedFeeds = isFirstPage
            ? data.content
            : [...state.feeds, ...data.content];

        // 새로운 검색어로 검색하는 경우 searchId 초기화
        final newSearchId = isFirstPage ? data.searchId : state.searchId;
        final newSearchVersion = isFirstPage ? data.searchVersion : state.searchVersion;

        print('[FeedSearchViewModel] Updated state:');
        print('  - feeds count: ${updatedFeeds.length}');
        print('  - searchId: $newSearchId');

        _state = state.copyWith(
          feeds: updatedFeeds,
          keyword: keyword,
          page: page,
          hasMore: !data.last,
          searchId: newSearchId,
          searchVersion: newSearchVersion,
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
    _state = state.copyWith(
      feeds: [],
      keyword: '',
      page: 0,
      hasMore: true,
      searchId: null,
      searchVersion: null,
    );
    notifyListeners();
  }

  // rank 계산: page * size + index + 1
  int calculateRank(int index) {
    return state.page * 20 + index + 1; // size는 20으로 고정
  }

  // 검색 결과 클릭 로그 전송 (fire-and-forget)
  Future<void> sendClickLog({
    required int recordId,
    required int rank,
  }) async {
    // searchId가 없으면 로그 전송하지 않음
    if (state.searchId == null || state.keyword.isEmpty) {
      print('[FeedSearchViewModel] Click log skipped - searchId: ${state.searchId}, keyword: ${state.keyword}');
      return;
    }

    print('[FeedSearchViewModel] Sending click log:');
    print('  - searchId: ${state.searchId}');
    print('  - keyword: ${state.keyword}');
    print('  - recordId: $recordId');
    print('  - rank: $rank');
    print('  - page: ${state.page}');

    // 비동기로 전송 (UX에 영향 없음)
    _feedApiRepository.postSearchClickLog(
      searchId: state.searchId!,
      keyword: state.keyword,
      recordId: recordId,
      rank: rank,
      page: state.page,
    ).then((result) {
      print('[FeedSearchViewModel] Click log result: $result');
      // 성공/실패 모두 조용히 처리 (fire-and-forget)
      // 사용자에게 오류를 노출하지 않음
    }).catchError((error) {
      print('[FeedSearchViewModel] Click log error: $error');
      // 에러도 조용히 처리
    });
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}
