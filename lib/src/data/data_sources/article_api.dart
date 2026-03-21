import 'package:dio/dio.dart';
import 'package:knittda/src/domain/model/article/article.dart';
import 'package:knittda/src/domain/model/article/article_detail.dart';

class ArticleApi {
  final Dio _dio;
  final String _apiBaseUrl;

  ArticleApi(this._dio, {required String apiBaseUrl}) : _apiBaseUrl = apiBaseUrl;

  Future<List<Article>> fetchArticles() async {
    final response = await _dio.get(
      '/items/articles',
      queryParameters: {'fields': '*'},
    );

    final data = response.data;

    // response.data가 이미 Map으로 파싱된 상태
    if (data is! Map<String, dynamic>) {
      throw FormatException('예상치 못한 응답 형식: ${data.runtimeType}');
    }

    // json.data가 배열인지 확인
    final list = data['data'];
    if (list is! List) {
      throw FormatException('data 필드가 배열이 아닙니다: ${list.runtimeType}');
    }

    return list.map((e) => Article.fromJson(e)).toList();
  }

  Future<ArticleDetail?> fetchArticleBySlug(String slugOrId) async {
    final isId = int.tryParse(slugOrId) != null;
    final filterKey = isId ? 'filter[id][_eq]' : 'filter[slug][_eq]';

    final response = await _dio.get(
      '/items/articles',
      queryParameters: {
        'fields': '*,sections.*,sections.item.*.*,sections.item.qa_item_block.gallery.*',
        filterKey: slugOrId,
      },
    );

    final data = response.data;

    if (data is! Map<String, dynamic>) {
      throw FormatException('예상치 못한 응답 형식: ${data.runtimeType}');
    }

    final list = data['data'];
    if (list is! List) {
      throw FormatException('data 필드가 배열이 아닙니다: ${list.runtimeType}');
    }

    if (list.isEmpty) return null;

    return ArticleDetail.fromJson(list.first);
  }

  String getAssetUrl(String assetId) {
    return '$_apiBaseUrl/api/assets/$assetId';
  }
}
