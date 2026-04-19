import 'package:knittda/src/domain/model/article/article.dart';
import 'package:knittda/src/domain/model/article/article_detail.dart';

abstract class ArticleRepository {
  Future<({List<Article> articles, int totalCount})> getArticles({
    int limit = 10,
    int offset = 0,
  });

  Future<ArticleDetail?> getArticleBySlug(String slugOrId);

  String getAssetUrl(String assetId);
}
