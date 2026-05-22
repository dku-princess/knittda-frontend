import 'package:freezed_annotation/freezed_annotation.dart';
import 'article_section.dart';

part 'article_detail.freezed.dart';

part 'article_detail.g.dart';

@freezed
abstract class ArticleDetail with _$ArticleDetail {
  const factory ArticleDetail({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String description,
    @Default('') String subtitle,
    @Default('') String category,
    @Default('') String editor,
    @Default('') String interviewee,
    @JsonKey(name: 'thumbnail_image_large') @Default('') String thumbnailImageLarge,
    @JsonKey(name: 'thumbnail_image_small') @Default('') String thumbnailImageSmall,
    @JsonKey(name: 'cover_image') String? coverImage,
    @JsonKey(name: 'published_at') @Default('') String publishedAt,
    @Default('') String slug,
    @Default('') String status,
    @Default([]) List<ArticleSection> sections,
    @Default(0) int sort,
  }) = _ArticleDetail;

  factory ArticleDetail.fromJson(Map<String, dynamic> json) =>
      _$ArticleDetailFromJson(json);
}