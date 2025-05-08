import 'dart:io';
import 'package:dio/dio.dart';
import '../models/user_model.dart';

class AuthRepository {
  /// Android 에뮬레이터(10.0.2.2) ↔ iOS 시뮬레이터·실단말(localhost) 자동 전환
  static final _baseUrl =
      'http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:3000/auth';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      contentType: 'application/json',
    ),
  );

  Future<({String refreshToken, String accessToken, UserModel user})> loginWithKakao(String token) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '/kakao',
        data: {'kakao_token': token},
      );

      final data = res.data;

      if (data == null) {
        throw Exception('빈 응답을 받았습니다.');
      }

      if (data['accessToken'] == null ||
          data['refreshToken'] == null ||
          data['user'] == null) {
        throw Exception('로그인 응답이 불완전합니다.');
      }

      return (
      refreshToken: data['refreshToken'] as String,
      accessToken: data['accessToken'] as String,
      user: UserModel.fromJson(data['user'])
      );
    } on DioException catch (e) {
      // 로그 또는 기본 에러 메시지 처리
      throw Exception('서버 요청 실패: ${e.message}');
    }
  }

}

