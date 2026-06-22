import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class RecordApi {
  final Dio _dio;

  RecordApi(this._dio);

  //개인 record 조회
  Future<Result<Iterable>> getRecords() async {
    try {
      final response = await _dio.get(
        '/api/v1/records/',
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

  //Record 업데이트
  Future<Result<Map<String, dynamic>>> putRecord({
    required Records record,
    required List<int>? deleteImageIds,
    required List<XFile>? files,
  }) async {
    try {
      final formData = FormData();

      formData.fields.add(MapEntry('record', jsonEncode(record.toJson())));

      if (deleteImageIds != null && deleteImageIds.isNotEmpty) {
        formData.fields.add(
          MapEntry('deleteImageIds', jsonEncode(deleteImageIds)),
        );
      }

      if (files != null && files.isNotEmpty) {
        for (final file in files) {
          formData.files.add(
            MapEntry(
              'files',
              await MultipartFile.fromFile(file.path, filename: file.name),
            ),
          );
        }
      }

      final response = await _dio.put(
        '/api/v1/records/',
        data: formData,
        options: Options(
          headers: {'accessToken': 'true'},
          sendTimeout: const Duration(seconds: 30),
        ),
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

  //Record 생성
  Future<Result<Map<String, dynamic>>> postRecord({
    required Records record,
    required List<XFile>? files,
  }) async {
    try {
      final formData = FormData();

      formData.fields.add(MapEntry('record', jsonEncode(record.toJson())));

      if (files != null && files.isNotEmpty) {
        for (final file in files) {
          formData.files.add(
            MapEntry(
              'files',
              await MultipartFile.fromFile(file.path, filename: file.name),
            ),
          );
        }
      }

      final response = await _dio.post(
        '/api/v1/records/',
        data: formData,
        options: Options(
          headers: {'accessToken': 'true'},
          sendTimeout: const Duration(seconds: 30),
        ),
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

  Future<Result<Map<String, dynamic>>> getRecord({
    required int recordId,
  }) async {
    try {
      final response = await _dio.get('/api/v1/records/$recordId');

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

  Future<Result<void>> deleteRecord({required int recordId}) async {
    try {
      final response = await _dio.delete(
        '/api/v1/records/$recordId',
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

  //프로젝트 별 Record 조회
  Future<Result<Iterable>> getRecordsProjects({required int projectId}) async {
    try {
      final response = await _dio.get('/api/v1/records/projects/$projectId');

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

  Future<Result<String>> getQuestion({required int projectId}) async {
    try {
      final response = await _dio.get('/api/v1/questions/generate/$projectId');

      if (response.statusCode == 200) {
        final data = response.data;
        final String hits = data['data'];
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
