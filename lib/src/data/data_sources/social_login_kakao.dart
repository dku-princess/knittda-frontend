import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:knittda/src/data/data_sources/social_login.dart';
import 'package:knittda/src/data/data_sources/social_login_result.dart';

class SocialLoginKakao implements SocialLogin {
  @override
  Future<SocialLoginResult?> login() async {
    final kakaoTalkInstalled = await isKakaoTalkInstalled();
    debugPrint('[KakaoLogin] 카카오톡 설치 여부: $kakaoTalkInstalled');

    if (kakaoTalkInstalled) {
      try {
        debugPrint('[KakaoLogin] 카카오톡 앱으로 로그인 시도');
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        debugPrint('[KakaoLogin] 카카오톡 로그인 성공');
        return SocialLoginResult(token: token.accessToken);
      } catch (error) {
        debugPrint('[KakaoLogin] 카카오톡 로그인 실패: $error');

        if (error is PlatformException && error.code == 'CANCELED') {
          debugPrint('[KakaoLogin] 사용자 취소');
          return null;
        }

        try {
          debugPrint('[KakaoLogin] 카카오계정으로 로그인 시도 (fallback)');
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          debugPrint('[KakaoLogin] 카카오계정 로그인 성공');
          return SocialLoginResult(token: token.accessToken);
        } catch (error) {
          debugPrint('[KakaoLogin] 카카오계정 로그인 실패: $error');
          return null;
        }
      }
    } else {
      try {
        debugPrint('[KakaoLogin] 카카오계정으로 로그인 시도 (카카오톡 미설치)');
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        debugPrint('[KakaoLogin] 카카오계정 로그인 성공');
        return SocialLoginResult(token: token.accessToken);
      } catch (error) {
        debugPrint('[KakaoLogin] 카카오계정 로그인 실패: $error');
        return null;
      }
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.logout();
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> unlink() async {
    try {
      await UserApi.instance.unlink();
      return true;
    } catch (e) {
      return false;
    }
  }
}
