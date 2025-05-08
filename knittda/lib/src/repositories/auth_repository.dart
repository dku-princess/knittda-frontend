import 'package:dio/dio.dart';
import '../models/user_model.dart';

class AuthRepository {
  static final baseUrl = 'http://13.125.122.193:8080';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json',
    ),
  );

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

      if (res.statusCode == 200) {
        final data = res.data;
        if (data == null) {
          throw Exception('응답 데이터가 없습니다.');
        }

        final jwt = data['jwt'] as String?;
        final userData = data['user'] as Map<String, dynamic>?;

        if (jwt == null || userData == null) {
          throw Exception('잘못된 응답 형식입니다.');
        }

        return (
        jwt: jwt,
        user: UserModel.fromJson(userData),
        );
      } else if (res.statusCode == 400) {
        throw Exception('잘못된 요청입니다. (400)');
      } else if (res.statusCode == 401) {
        throw Exception('인증 실패입니다. (401)');
      } else {
        throw Exception('알 수 없는 오류 발생: ${res.statusCode}');
      }
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == 400) {
        throw Exception('잘못된 요청입니다. (400)');
      } else if (status == 401) {
        throw Exception('인증 실패입니다. (401)');
      } else {
        throw Exception('서버 요청 실패: ${e.message}');
      }
    } catch (e) {
      throw Exception('로그인 처리 중 오류 발생: $e');
    }
  }
}

