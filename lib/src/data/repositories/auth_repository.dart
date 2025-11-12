import 'package:dio/dio.dart';
import '../models/user_model.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<({String jwt, UserModel user})> loginWithKakao(String token) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        '/api/v1/auth/kakao',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      // HTTP 코드 체크
      if (res.statusCode != 200) {
        throw Exception('서버 오류: ${res.statusCode}');
      }

      //debugPrint('서버 응답: ${res.data}');

      // 최상위 응답 파싱
      final body = res.data;
      if (body == null || body['success'] != true) {
        throw Exception(body?['message'] ?? '알 수 없는 오류');
      }

      // 실제 데이터 꺼내기
      final payload = body['data'] as Map<String, dynamic>?;
      final jwt  = payload?['jwt']  as String?;
      final user = payload?['user'] as Map<String, dynamic>?;

      if (jwt == null || user == null) {
        throw Exception('잘못된 응답 형식');
      }

      return (jwt: jwt, user: UserModel.fromJson(user));

    } on DioException catch (e) {
      final code = e.response?.statusCode;
      switch (code) {
        case 400: throw Exception('잘못된 요청입니다. (400)');
        case 401: throw Exception('인증 실패입니다. (401)');
        default : throw Exception('네트워크 오류: ${e.message}');
      }
    } catch (e) {
      throw Exception('로그인 처리 중 오류: $e');
    }
  }

  Future<({UserModel user})> me() async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        '/api/v1/auth/me',
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      // HTTP 코드 체크
      if (res.statusCode != 200) {
        throw Exception('서버 오류: ${res.statusCode}');
      }

      //debugPrint('서버 응답: ${res.data}');

      // 최상위 응답 파싱
      final body = res.data;
      if (body == null || body['success'] != true) {
        throw Exception(body?['message'] ?? '알 수 없는 오류');
      }

      // 실제 데이터 꺼내기
      final user = body['data'] as Map<String, dynamic>?;
      if (user == null) {
        throw Exception('잘못된 응답 형식');
      }

      return (user: UserModel.fromJson(user));

    } on DioException catch (e) {
      final code = e.response?.statusCode;
      switch (code) {
        case 400: throw Exception('잘못된 요청입니다. (400)');
        case 401: throw Exception('인증 실패입니다. (401)');
        default : throw Exception('네트워크 오류: ${e.message}');
      }
    } catch (e) {
      throw Exception('사용자 정보 불러오기 중 오류: $e');
    }
  }

  Future<bool> signout() async {
    try {
      final res = await _dio.delete<Map<String, dynamic>>(
        '/api/v1/auth/signout',
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      // 성공 조건만 확인
      if (res.statusCode == 200 && res.data?['success'] == true) {
        return true;
      }

      // 200이 아닌 모든 경우 → 예외
      throw Exception(res.data?['message'] ?? '탈퇴 실패');
    } on DioException catch (e) {
      // DioException(네트워크 오류 등)은 하나로 묶어서 던지기
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      // 기타 예외도 동일하게
      throw Exception('탈퇴 중 오류: $e');
    }
  }

  Future<({String jwt, UserModel user})> loginWithApple(String token, {String? name}) async {
    try {
      // name은 항상 query parameter로 전송 (없으면 빈 문자열)
      final res = await _dio.get<Map<String, dynamic>>(
        '/api/v1/auth/apple',
        queryParameters: {'name': name ?? ''},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      // HTTP 코드 체크
      if (res.statusCode != 200) {
        throw Exception('서버 오류: ${res.statusCode}');
      }

      // 최상위 응답 파싱
      final body = res.data;
      if (body == null || body['success'] != true) {
        throw Exception(body?['message'] ?? '알 수 없는 오류');
      }

      // 실제 데이터 꺼내기
      final payload = body['data'] as Map<String, dynamic>?;
      final jwt  = payload?['jwt']  as String?;
      final user = payload?['user'] as Map<String, dynamic>?;

      if (jwt == null || user == null) {
        throw Exception('잘못된 응답 형식');
      }

      return (jwt: jwt, user: UserModel.fromJson(user));

    } on DioException catch (e) {
      final code = e.response?.statusCode;
      switch (code) {
        case 400: throw Exception('잘못된 요청입니다. (400)');
        case 401: throw Exception('인증 실패입니다. (401)');
        default : throw Exception('네트워크 오류: ${e.message}');
      }
    } catch (e) {
      throw Exception('로그인 처리 중 오류: $e');
    }
  }

  Future<({String jwt, UserModel user})> admin() async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        '/api/v1/auth/admin',
      );

      if (res.statusCode != 200) {
        throw Exception('서버 오류: ${res.statusCode}');
      }

      final body = res.data;
      if (body == null || body['success'] != true) {
        throw Exception(body?['message'] ?? '알 수 없는 오류');
      }

      final payload = body['data'] as Map<String, dynamic>?;
      final jwt  = payload?['jwt']  as String?;
      final user = payload?['user'] as Map<String, dynamic>?;

      if (jwt == null || user == null) {
        throw Exception('잘못된 응답 형식');
      }

      return (jwt: jwt, user: UserModel.fromJson(user));

    } on DioException catch (e) {
      final code = e.response?.statusCode;
      switch (code) {
        case 400: throw Exception('잘못된 요청입니다. (400)');
        case 401: throw Exception('인증 실패입니다. (401)');
        default : throw Exception('네트워크 오류: ${e.message}');
      }
    } catch (e) {
      throw Exception('로그인 처리 중 오류: $e');
    }
  }

}

