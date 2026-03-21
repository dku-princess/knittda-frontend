import 'package:knittda/src/domain/model/article/article.dart';
import 'package:knittda/src/domain/model/article/article_detail.dart';

abstract class ArticleRepository {
  Future<List<Article>> getArticles();

  Future<ArticleDetail?> getArticleBySlug(String slugOrId);

  String getAssetUrl(String assetId);
}
