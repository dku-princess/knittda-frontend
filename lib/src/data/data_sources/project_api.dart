import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';

class ProjectApi {
  final Dio _dio;

  ProjectApi(this._dio);

  Future<Result<Iterable>> getProjects() async {
    try {
      final response = await _dio.get('/api/v1/projects/');

      if (response.statusCode == 200) {
        final data = response.data;
        final Iterable hits = data['data'];
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

      final response = await _dio.put('/api/v1/projects/', data: formData);

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

      final response = await _dio.post('/api/v1/projects/', data: formData);

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
        return Result.error('서버 오류: ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Result.error('네트워크 에러: ${e.message}');
    } catch (e) {
      return Result.error('알 수 없는 에러');
    }
  }

  Future<Result<void>> deleteProject({required int projectId}) async {
    try {
      final response = await _dio.delete('/api/v1/projects/$projectId');

      if (response.statusCode == 200) {
        return Result.success(null);
      } else {
        return Result.error('서버 오류: ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Result.error('네트워크 에러: ${e.message}');
    } catch (e) {
      return Result.error('알 수 없는 에러');
    }
  }

  Future<Result<Iterable>> getProjectPreviews() async {
    try {
      final response = await _dio.get('/api/v1/projects/previews');

      if (response.statusCode == 200) {
        final data = response.data;
        final Iterable hits = data['data'];
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

  Future<Result<Map<String, dynamic>>> getMyProject({
    required int projectId,
  }) async {
    try {
      final response = await _dio.get('/api/v1/projects/my/$projectId');

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
