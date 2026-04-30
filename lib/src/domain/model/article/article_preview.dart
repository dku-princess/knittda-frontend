import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_preview.freezed.dart';

part 'article_preview.g.dart';

@freezed
abstract class ArticlePreview with _$ArticlePreview {
  factory ArticlePreview({
    required int projectId,
    required String projectName,
    String? thumbnailUrl,
    String? nickname,
  }) = _ArticlePreview;

  factory ArticlePreview.fromJson(Map<String, dynamic> json) =>
      _$ArticlePreviewFromJson(json);
}

@freezed
abstract class ArticlePreviewData with _$ArticlePreviewData {
  factory ArticlePreviewData({
    required int num,
    required List<ArticlePreview> projects,
  }) = _ArticlePreviewData;

  factory ArticlePreviewData.fromJson(Map<String, dynamic> json) =>
      _$ArticlePreviewDataFromJson(json);
}
