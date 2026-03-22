import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/article/article.dart';

part 'article_list_state.freezed.dart';

@freezed
abstract class ArticleListState with _$ArticleListState {
  factory ArticleListState({
    required List<Article> articles,
    required bool isLoading,
    String? errorMessage,
  }) = _ArticleListState;
}
