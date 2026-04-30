import 'package:dio/dio.dart';
import 'package:knittda/src/data/data_sources/article_api.dart';
import 'package:knittda/src/domain/model/article/article.dart';
import 'package:knittda/src/domain/model/article/article_detail.dart';
import 'package:knittda/src/domain/repository/article_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleApi _api;

  ArticleRepositoryImpl(this._api);

  @override
  Future<({List<Article> articles, int totalCount})> getArticles({
    int limit = 15,
    int offset = 0,
  }) async {
    try {
      return await _api.fetchArticles(limit: limit, offset: offset);
    } on DioException catch (e, st) {
      Sentry.captureException(e, stackTrace: st);
      throw _handleDioError(e);
    } on FormatException catch (e, st) {
      Sentry.captureException(e, stackTrace: st);
      throw Exception('서버 응답을 파싱할 수 없습니다.');
    }
  }

  @override
  Future<ArticleDetail?> getArticleBySlug(String slugOrId) async {
    try {
      return await _api.fetchArticleBySlug(slugOrId);
    } on DioException catch (e, st) {
      Sentry.captureException(e, stackTrace: st);
      throw _handleDioError(e);
    } on FormatException catch (e, st) {
      Sentry.captureException(e, stackTrace: st);
      throw Exception('서버 응답을 파싱할 수 없습니다.');
    }
  }

  @override
  String getAssetUrl(String assetId) => _api.getAssetUrl(assetId);

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('서버 연결 시간이 초과되었습니다.');
      case DioExceptionType.connectionError:
        return Exception('네트워크에 연결할 수 없습니다.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return Exception('요청한 데이터를 찾을 수 없습니다.');
        }
        return Exception('서버 오류가 발생했습니다. ($statusCode)');
      default:
        return Exception('알 수 없는 오류가 발생했습니다.');
    }
  }
}
