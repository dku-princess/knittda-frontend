import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';

part 'article.g.dart';

@freezed
abstract class Article with _$Article {
  factory Article({
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
    @JsonKey(name: 'is_featured') @Default(false) bool isFeatured,
    @Default('') String slug,
    @Default('') String status,
    List<int>? sections,

    @JsonKey(name: 'date_created') String? dateCreated,
    @JsonKey(name: 'date_updated') String? dateUpdated,
    @JsonKey(name: 'user_created') String? userCreated,
    @JsonKey(name: 'user_updated') String? userUpdated,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
