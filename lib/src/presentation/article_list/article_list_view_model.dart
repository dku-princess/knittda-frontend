import 'package:flutter/material.dart';
import 'package:knittda/src/domain/repository/article_repository.dart';
import 'package:knittda/src/presentation/article_list/article_list_event.dart';
import 'package:knittda/src/presentation/article_list/article_list_state.dart';

class ArticleListViewModel extends ChangeNotifier {
  final ArticleRepository _repository;
  static const _pageSize = 15;

  ArticleListState _state = ArticleListState();

  ArticleListState get state => _state;

  ArticleListViewModel(this._repository) {
    _loadArticles();
  }

  Future<void> onEvent(ArticleListEvent event) async {
    switch (event) {
      case LoadArticles():
        await _loadArticles();
      case LoadMore():
        await _loadMore();
    }
  }

  Future<void> _loadArticles() async {
    _state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final result = await _repository.getArticles(limit: _pageSize, offset: 0);
      _state = state.copyWith(
        articles: result.articles,
        totalCount: result.totalCount,
      );
    } on Exception catch (e) {
      final error = e.toString().replaceFirst('Exception: ', '');
      _state = state.copyWith(errorMessage: error);
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> _loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    _state = state.copyWith(isLoadingMore: true);
    notifyListeners();

    try {
      final result = await _repository.getArticles(
        limit: _pageSize,
        offset: state.articles.length,
      );
      final updated = [...state.articles, ...result.articles];
      _state = state.copyWith(articles: updated, totalCount: result.totalCount);
    } on Exception catch (e) {
      debugPrint('추가 로딩 실패: $e');
    }

    _state = state.copyWith(isLoadingMore: false);
    notifyListeners();
  }

  String getAssetUrl(String assetId) => _repository.getAssetUrl(assetId);
}
