import 'package:dio/dio.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ReportApi {
  final Dio _dio;

  ReportApi(this._dio);

  Future<Result<Map<String, dynamic>>> getReport() async {
    try {
      final response = await _dio.post(
        '/api/v1/report/',
        options: Options(headers: {'accessToken': 'true'}),
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
}
