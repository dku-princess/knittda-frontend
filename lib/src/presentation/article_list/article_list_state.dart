import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/article/article.dart';

part 'article_list_state.freezed.dart';

@freezed
abstract class ArticleListState with _$ArticleListState {
  const ArticleListState._();

  const factory ArticleListState({
    @Default([]) List<Article> articles,
    @Default(false) bool isLoading,
    String? errorMessage,

    @Default(false) bool isLoadingMore,
    @Default(0) int totalCount,
  }) = _ArticleListState;

  bool get hasMore => articles.length < totalCount;
}
