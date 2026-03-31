import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_list_event.freezed.dart';

@freezed
sealed class ArticleListEvent with _$ArticleListEvent {
  const factory ArticleListEvent.fetchArticles() = FetchArticles;
}