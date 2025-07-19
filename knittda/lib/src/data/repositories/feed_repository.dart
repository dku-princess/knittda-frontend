import 'package:dio/dio.dart';
import 'package:knittda/src/data/models/feed_model.dart';

class FeedRemoteException implements Exception {
  final Object error;
  final StackTrace stackTrace;
  FeedRemoteException(this.error, this.stackTrace);

  @override
  String toString() => 'FeedRemoteException: $error\n$stackTrace';
}

class FeedRepository {
  final Dio _dio;
  FeedRepository(this._dio);

  Future<List<FeedModel>> fetchFeeds({
    required int page,
    required int size,
    List<String>? sort,
  }) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        '/api/v1/feed/',
        queryParameters: {
          'page': page,
          'size': size,
          if (sort != null) 'sort': sort.join(','),
        },
      );

      final content = res.data?['data']?['content'] as List<dynamic>? ?? [];
      return content.map((e) => FeedModel.fromJson(e)).toList();
    } on DioException catch (e, s) {
      throw FeedRemoteException(e, s);
    }
  }

  Future<List<FeedModel>> searchFeeds({
    required String keyword,
    required int page,
    required int size,
    List<String>? sort,
  }) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        '/api/v1/feed/v2/search',
        queryParameters: {
          'keyword': keyword,
          'page' : page,
          'size' : size,
          if (sort != null) 'sort': sort.join(','),
        },
      );

      final content = res.data?['data']?['content'] as List<dynamic>? ?? [];
      return content.map((e) => FeedModel.fromJson(e)).toList();
    } on DioException catch (e, s) {
      throw FeedRemoteException(e, s);
    }
  }

}
