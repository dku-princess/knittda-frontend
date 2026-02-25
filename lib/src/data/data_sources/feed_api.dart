import 'package:dio/dio.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
        final error = '서버 오류: ${response.statusCode}';
        Sentry.captureException(error, stackTrace: StackTrace.current);
        return Result.error(error);
      }
    } on DioException catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      return Result.error('네트워크 에러: ${e.message}');
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
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
        '/api/v1/feed/search',
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
        final error = '서버 오류: ${response.statusCode}';
        Sentry.captureException(error, stackTrace: StackTrace.current);
        return Result.error(error);
      }
    } on DioException catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      return Result.error('네트워크 에러: ${e.message}');
    } catch (e, stack) {
      Sentry.captureException(e, stackTrace: stack);
      return Result.error('알 수 없는 에러');
    }
  }

  // 검색 결과 클릭 로그 전송
  Future<Result<void>> postSearchClickLog({
    required String searchId,
    required String keyword,
    required int recordId,
    required int rank,
    required int page,
  }) async {
    try {
      final requestData = {
        'searchId': searchId,
        'keyword': keyword,
        'recordId': recordId,
        'clickRank': rank,  // 서버는 clickRank를 기대함
        'page': page,
      };
      
      final response = await _dio.post(
        '/api/v1/feed/search/log/click',
        data: requestData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Result.success(null);
      } else {
        // 로그 전송 실패는 사용자에게 노출하지 않음 (fire-and-forget)
        return Result.error('로그 전송 실패');
      }
    } on DioException catch (e) {
      // 네트워크 에러도 조용히 처리 (fire-and-forget)
      return Result.error('네트워크 에러: ${e.message}');
    } catch (e) {
      return Result.error('알 수 없는 에러');
    }
  }
}
