import 'package:freezed_annotation/freezed_annotation.dart';
import 'article_section.dart';

part 'article_detail.freezed.dart';

part 'article_detail.g.dart';

@freezed
abstract class ArticleDetail with _$ArticleDetail {
  const factory ArticleDetail({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String subtitle,
    @Default('') String category,
    @Default('') String editor,
    @Default('') String interviewee,
    @JsonKey(name: 'thumbnail_image_large') @Default('') String thumbnailImageLarge,
    @JsonKey(name: 'thumbnail_image_small') @Default('') String thumbnailImageSmall,
    @JsonKey(name: 'cover_image') String? coverImage,
    @JsonKey(name: 'published_at') @Default('') String publishedAt,
    @JsonKey(name: 'is_featured') @Default(false) bool isFeatured,
    @Default('') String slug,
    @Default('') String status,
    @Default([]) List<ArticleSection> sections,
  }) = _ArticleDetail;

  factory ArticleDetail.fromJson(Map<String, dynamic> json) =>
      _$ArticleDetailFromJson(json);
}