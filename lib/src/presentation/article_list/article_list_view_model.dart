import 'package:flutter/material.dart';
import 'package:knittda/src/domain/repository/article_repository.dart';
import 'package:knittda/src/presentation/article_list/article_list_event.dart';
import 'package:knittda/src/presentation/article_list/article_list_state.dart';

class ArticleListViewModel extends ChangeNotifier {
  final ArticleRepository _repository;
  static const _pageSize = 10;

  ArticleListState _state = ArticleListState(
    articles: [],
    isLoading: false,
    isLoadingMore: false,
    hasMore: false,
    currentOffset: 0,
  );

  ArticleListState get state => _state;

  ArticleListViewModel(this._repository) {
    _fetchArticles();
  }

  Future<void> onEvent(ArticleListEvent event) async {
    switch (event) {
      case FetchArticles():
        await _fetchArticles();
      case FetchMore():
        await _fetchMore();
    }
  }

  //초기 로드 또는 새로고침
  Future<void> _fetchArticles() async {
    _state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final result = await _repository.getArticles(limit: _pageSize, offset: 0);
      _state = state.copyWith(
        articles: result.articles,
        currentOffset: result.articles.length,
        hasMore: result.articles.length < result.totalCount,
      );
    } on Exception catch (e) {
      final error = e.toString().replaceFirst('Exception: ', '');
      _state = state.copyWith(errorMessage: error);
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> _fetchMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    _state = state.copyWith(isLoadingMore: true);
    notifyListeners();
    try {
      final result = await _repository.getArticles(
        limit: _pageSize,
        offset: state.currentOffset,
      );
      final allArticles = [...state.articles, ...result.articles];
      _state = state.copyWith(
        articles: allArticles,
        currentOffset: allArticles.length,
        hasMore: allArticles.length < result.totalCount,
      );
    } on Exception catch (e) {
      debugPrint('추가 로딩 실패: $e');
    }
    _state = state.copyWith(isLoadingMore: false);
    notifyListeners();
  }

  String getAssetUrl(String assetId) => _repository.getAssetUrl(assetId);
}
