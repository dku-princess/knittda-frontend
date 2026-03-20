import 'package:dio/dio.dart';
import 'package:knittda/src/domain/model/cmd/article.dart';

class ArticleApi {
  final Dio _dio;

  ArticleApi(this._dio);
  
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

    //json.data가 배열인지 확인
    final list = data['data'];
    if (list is! List) {
      throw FormatException('data 필드가 배열이 아닙니다: ${list.runtimeType}');
    }

    return list.map((e) => Article.fromJson(e)).toList();
  }
}
