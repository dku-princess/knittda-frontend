import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/performance/initial_load_tracker.dart';
import 'package:knittda/src/domain/model/article/article_preview.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ProjectApi {
  final Dio _dio;

  ProjectApi(this._dio);

  Future<Result<Iterable>> getMyProjects() async {
    try {
      final response = await _dio.get(
        '/api/v1/projects/my',
        options: Options(headers: {'accessToken': 'true'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final Iterable hits = data['data'];
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

  // 프로젝트 수정
  Future<Result<Map<String, dynamic>>> putProject({
    required Project project,
    required XFile? file,
  }) async {
    try {
      final formData = FormData.fromMap({
        'project': jsonEncode(project.toJson()),
        if (file != null)
          'file': await MultipartFile.fromFile(file.path, filename: file.name),
      });

      final response = await _dio.put(
        '/api/v1/projects/',
        data: formData,
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

  //프로젝트 생성
  Future<Result<Map<String, dynamic>>> postProject({
    required Project project,
    required XFile? file,
  }) async {
    try {
      final formData = FormData.fromMap({
        'project': jsonEncode(project.toJson()),
        if (file != null)
          'file': await MultipartFile.fromFile(
            file.path,
            filename: file.name,
            contentType: MediaType('image', 'jpeg'),
          ),
      });

      final response = await _dio.post(
        '/api/v1/projects/',
        data: formData,
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

  Future<Result<Map<String, dynamic>>> getProject({
    required int projectId,
  }) async {
    try {
      final response = await _dio.get('/api/v1/projects/$projectId');

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

  Future<Result<void>> deleteProject({required int projectId}) async {
    try {
      final response = await _dio.delete(
        '/api/v1/projects/$projectId',
        options: Options(headers: {'accessToken': 'true'}),
      );

      if (response.statusCode == 200) {
        return Result.success(null);
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

  Future<Result<Iterable>> getProjectPreviews() async {
    try {
      final tracker = InitialLoadTracker.projectPreviews;
      if (tracker.isSessionActive) {
        tracker.markT2();
      }
      final response = await _dio.get('/api/v1/projects/previews');
      if (tracker.isSessionActive) {
        tracker.markT3();
      }

      if (response.statusCode == 200) {
        final data = response.data;
        final Iterable hits = data['data'];
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

  Future<Result<Map<String, dynamic>>> getMyProject({
    required int projectId,
  }) async {
    try {
      final response = await _dio.get(
        '/api/v1/projects/my/$projectId',
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

  Future<ArticlePreviewData> getArticlePreviews({
    required List<int> ids,
  }) async {
    final uniqueIds = ids.toSet().toList();

    final response = await _dio.get(
      '/api/v1/projects/article-previews',
      queryParameters: {'ids': uniqueIds.join(',')},
    );

    final data = response.data;
    if (data['success'] != true) {
      throw Exception('API 오류 [${data['code']}]: ${data['message']}');
    }

    return ArticlePreviewData.fromJson(data['data']);
  }
}
