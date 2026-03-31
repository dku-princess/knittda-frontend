import 'package:flutter/material.dart';
import 'package:knittda/src/domain/repository/article_repository.dart';
import 'package:knittda/src/presentation/article_list/article_list_event.dart';
import 'package:knittda/src/presentation/article_list/article_list_state.dart';

class ArticleListViewModel extends ChangeNotifier{
  final ArticleRepository _repository;

  ArticleListState _state = ArticleListState(articles: [], isLoading: false);

  ArticleListState get state => _state;

  ArticleListViewModel(this._repository){
    _fetchArticles();
  }

  Future<void> onEvent(ArticleListEvent event) async {
    switch (event) {
      case FetchArticles():
        await _fetchArticles();
    }
  }

  Future<void> _fetchArticles() async {
    _state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final articles = await _repository.getArticles();
      _state = state.copyWith(articles: articles);
    } on Exception catch (e) {
      final error = e.toString().replaceFirst('Exception: ', '');
      _state = state.copyWith(errorMessage: error);
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  String getAssetUrl(String assetId) => _repository.getAssetUrl(assetId);
}