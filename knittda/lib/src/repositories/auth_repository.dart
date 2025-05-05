import 'dart:io';
import 'package:dio/dio.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
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

  /// 카카오 accessToken으로 인증 → (없으면) 가입 → UserModel 반환
  Future<UserModel?> authenticateWithKakao(String accessToken) async {
    try {
      // 1) 로그인 시도
      final res = await _postToken(accessToken);

      // 2) 미가입(404) → 회원가입 후 user 반환
      if (res.statusCode == 404) {
        final profile = await UserApi.instance.me();

        final signUpRes = await _signUp(
          accessToken: accessToken,
          kakaoId: profile.id.toString(),
          nickname: profile.kakaoAccount?.profile?.nickname ?? '',
        );

        if (signUpRes.statusCode == 201) {
          return UserModel.fromJson(
              Map<String, dynamic>.from(signUpRes.data));
        }

        // 가입 실패
        print('[AuthRepository] sign‑up failed '
            '${signUpRes.statusCode}: ${signUpRes.data}');
        return null;
      }

      // 3) 기존 회원(200) → user 반환
      if (res.statusCode == 200) {
        return UserModel.fromJson(Map<String, dynamic>.from(res.data));
      }

      // 4) 그밖의 응답 → 실패
      print('[AuthRepository] auth failed '
          '${res.statusCode}: ${res.data}');
      return null;
    } catch (e, s) {
      // 네트워크·직렬화 예외 방어
      print('[AuthRepository] exception: $e');
      print(s);
      return null;
    }
  }

  Future<Response> _postToken(String accessToken) {
    return _dio.post(
      '/kakao', // 최종 URL: $baseUrl/kakao
      data: {'access_token': accessToken},
    );
  }

  Future<Response> _signUp({
    required String accessToken,
    required String kakaoId,
    required String nickname,
  }) {
    return _dio.post(
      '/kakao/signup', // 최종 URL: $baseUrl/kakao/signup
      data: {
        'access_token': accessToken,
        'kakao_id': kakaoId,
        'nickname': nickname,
      },
    );
  }
}

