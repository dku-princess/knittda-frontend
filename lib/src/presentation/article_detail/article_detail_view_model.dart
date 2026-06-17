import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/analytics_service.dart';
import 'package:knittda/src/domain/model/article/article_preview.dart';
import 'package:knittda/src/domain/model/article/project_section.dart';
import 'package:knittda/src/domain/repository/article_repository.dart';
import 'package:knittda/src/domain/use_case/get_article_previews_use_case.dart';
import 'package:knittda/src/presentation/article_detail/article_detail_state.dart';

class ArticleDetailViewModel extends ChangeNotifier {
  final ArticleRepository _repository;
  final GetArticlePreviewsUseCase _getArticlePreviewsUseCase;

  ArticleDetailState _state = ArticleDetailState(
    article: null,
    isLoading: false,
    articlePreviews: [],
  );

  ArticleDetailState get state => _state;

  ArticleDetailViewModel(
    this._repository,
    this._getArticlePreviewsUseCase, {
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
      if (article != null) {
        AnalyticsService.instance.logViewArticle(article.id.toString());
      }

      if (article != null) {
        final ids = article.sections
            .where((s) => s.collection == 'project_section' && s.item != null)
            .expand((s) {
              try {
                return ProjectSection.fromJson(s.item!).projectItemBlock;
              } catch (e) {
                debugPrint('ProjectSection 파싱 실패: $e');
                return <ProjectItemBlock>[];
              }
            })
            .map((b) => b.projectId)
            .where((id) => id != 0)
            .toList();

        if (ids.isNotEmpty) {
          try {
            final previews = await _getArticlePreviewsUseCase(ids: ids);
            _state = state.copyWith(articlePreviews: previews);
          } catch (_) {
            _state = state.copyWith(articlePreviews: []);
          }
        }
      }
    } on Exception catch (e) {
      final error = e.toString().replaceFirst('Exception: ', '');
      _state = state.copyWith(errorMessage: error);
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  ArticlePreview? getArticlePreview(int projectId) {
    try {
      return state.articlePreviews.firstWhere((p) => p.projectId == projectId);
    } catch (_) {
      return null;
    }
  }

  String getAssetUrl(String assetId) => _repository.getAssetUrl(assetId);
}
