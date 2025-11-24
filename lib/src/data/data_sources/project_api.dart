import 'package:dio/dio.dart';
import 'package:knittda/src/data/data_sources/result.dart';

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

  Future<Result<Map<String, dynamic>>> putProject() async {
    try {
      final response = await _dio.get('/api/v1/projects/');

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

  Future<Result<Map<String, dynamic>>> postProject() async {
    try {
      final response = await _dio.get('/api/v1/projects/');

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
}
