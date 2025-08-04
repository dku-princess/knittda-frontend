import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter/foundation.dart';
import 'package:knittda/src/data/data_sources/social_login.dart';

class KaKaoLogin implements SocialLogin {
  @override
  Future<String?> login() async {
    // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        return token.accessToken;
      } catch (error) {
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          return token.accessToken;
        } catch (error) {
          return null;
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        return token.accessToken;
      } catch (error) {
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

  // 웹 로그인 전용 메서드 (iOS 17+ 충돌 문제 해결)
  Future<String?> loginWithWebOnly() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      debugPrint('카카오계정으로 로그인 성공 ${token.accessToken}');
      return token.accessToken;
    } catch (error) {
      debugPrint('카카오계정으로 로그인 실패 $error');
      return null;
    }
  }
}