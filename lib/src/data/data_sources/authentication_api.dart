import 'package:dio/dio.dart';
import 'package:knittda/src/data/data_sources/result.dart';

class AuthenticationApi {
  final Dio _dio;

  AuthenticationApi(this._dio);

  //사용자 정보 조회
  Future<Result<Map<String, dynamic>>> getAuthMe() async {
    try {
      final response = await _dio.get('/api/v1/auth/me');

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

  //카카오 로그인
  Future<Result<Map<String, dynamic>>> getAuthKakao({
    required String token,
  }) async {
    try {
      final response = await _dio.get(
        '/api/v1/auth/kakao',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
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

  Future<Result<Map<String, dynamic>>> getAuthApple({
    required String token,
    required String name,
  }) async {
    try {
      final response = await _dio.get(
        '/api/v1/auth/apple',
        queryParameters: {'name': name},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
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

  //관리자
  Future<Result<Map<String, dynamic>>> getAuthAdmin() async {
    try {
      final response = await _dio.get('/api/v1/auth/admin');

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

  //탈퇴
  Future<Result<void>> deleteAuthSignout() async {
    try {
      final response = await _dio.delete('/api/v1/auth/signout');

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
}
