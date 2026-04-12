import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/article/article_detail.dart';
import 'package:knittda/src/domain/model/article/article_preview.dart';

part 'article_detail_state.freezed.dart';

@freezed
abstract class ArticleDetailState with _$ArticleDetailState {
  factory ArticleDetailState({
    required ArticleDetail? article,
    required bool isLoading,
    String? errorMessage,
    required List<ArticlePreview> articlePreviews,
  }) = _ArticleDetailState;
}
