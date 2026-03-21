import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_section.freezed.dart';

part 'article_section.g.dart';

@freezed
abstract class ArticleSection with _$ArticleSection {
  const factory ArticleSection({
    @Default(0) int id,
    @JsonKey(name: 'articles_id') @Default(0) int articlesId,
    @Default('') String collection,
    @Default(0) int sort,
    Map<String, dynamic>? item,
  }) = _ArticleSection;

  factory ArticleSection.fromJson(Map<String, dynamic> json) =>
      _$ArticleSectionFromJson(json);
}
