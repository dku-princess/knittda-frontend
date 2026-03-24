import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project_previews.dart';
import 'package:knittda/src/domain/repository/article_repository.dart';
import 'package:knittda/src/domain/use_case/get_project_previews_use_case.dart';
import 'package:knittda/src/presentation/article_detail/article_detail_state.dart';

class ArticleDetailViewModel extends ChangeNotifier {
  final ArticleRepository _repository;
  final GetProjectPreviewsUseCase _getProjectPreviewsUseCase;

  ArticleDetailState _state = ArticleDetailState(
    article: null,
    isLoading: false,
    projectPreviews: [],
  );

  ArticleDetailState get state => _state;

  ArticleDetailViewModel(
    this._repository,
    this._getProjectPreviewsUseCase, {
    required String slugOrId,
  }) {
    fetchArticle(slugOrId);
  }

  Future<void> fetchArticle(String slugOrId) async {
    _state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final article = await _repository.getArticleBySlug(slugOrId);
      _state = state.copyWith(article: article);

      if (article != null &&
          article.sections.any((s) => s.collection == 'project_section')) {
        final result = await _getProjectPreviewsUseCase();
        switch (result) {
          case Success(:final data):
            _state = state.copyWith(projectPreviews: data);
          case Error():
            _state = state.copyWith(projectPreviews: []);
        }
      }
    } on Exception catch (e) {
      final error = e.toString().replaceFirst('Exception: ', '');
      _state = state.copyWith(errorMessage: error);
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  ProjectPreviews? getProjectPreview(int projectId) {
    try {
      return state.projectPreviews.firstWhere((p) => p.projectId == projectId);
    } catch (_) {
      return null;
    }
  }

  String getAssetUrl(String assetId) => _repository.getAssetUrl(assetId);
}
