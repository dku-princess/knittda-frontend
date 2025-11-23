import 'package:dio/dio.dart';
import 'package:knittda/src/data/data_sources/result.dart';

class FeedApi {
  final Dio _dio;

  FeedApi(this._dio);

  Future<Result<Map<String, dynamic>>> getFeed(
    int page,
    int size,
    List<String>? sort,
  ) async {
    try {
      final response = await _dio.get(
        '/api/v1/feed/',
        queryParameters: {
          'page': page,
          'size': size,
          if (sort != null) 'sort': sort,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final Map<String, dynamic> hits = data['data'];
        return Result.success(hits);
      } else {
        return Result.error('서버 오류: ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Result.error('네트워크 에러: ${e.message}');
    } catch (e) {
      return Result.error('알 수 없는 에러');
    }
  }

  Future<Result<Map<String, dynamic>>> getSearchFeed(
    String keyword,
    int page,
    int size,
    List<String>? sort,
  ) async {
    try {
      final response = await _dio.get(
        'url',
        queryParameters: {
          'keyword': keyword,
          'page': page,
          'size': size,
          if (sort != null) 'sort': sort,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final Map<String, dynamic> hits = data['data'];
        return Result.success(hits);
      } else {
        return Result.error('서버 오류: ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Result.error('네트워크 에러: ${e.message}');
    } catch (e) {
      return Result.error('알 수 없는 에러');
    }
  }
}
