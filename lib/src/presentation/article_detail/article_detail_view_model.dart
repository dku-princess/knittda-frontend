import 'package:flutter/material.dart';
import 'package:knittda/src/domain/repository/article_repository.dart';
import 'package:knittda/src/presentation/article_detail/article_detail_state.dart';

class ArticleDetailViewModel extends ChangeNotifier {
  final ArticleRepository _repository;

  ArticleDetailState _state = ArticleDetailState(article: null, isLoading: false);

  ArticleDetailState get state => _state;

  ArticleDetailViewModel(this._repository, {required String slugOrId}){
    fetchArticle(slugOrId);
  }

  Future<void> fetchArticle(String slugOrId) async {
    _state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final article = await _repository.getArticleBySlug(slugOrId);
      _state = state.copyWith(article: article);
    } on Exception catch (e) {
      final error = e.toString().replaceFirst('Exception: ', '');
      _state = state.copyWith(errorMessage: error);
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  String getAssetUrl(String assetId) => _repository.getAssetUrl(assetId);
}
