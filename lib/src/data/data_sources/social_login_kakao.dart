import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:knittda/src/data/data_sources/social_login.dart';
import 'package:knittda/src/data/data_sources/social_login_result.dart';

class SocialLoginKakao implements SocialLogin {
  @override
  Future<SocialLoginResult?> login() async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        return SocialLoginResult(token: token.accessToken);
        // 카카오톡으로 로그인 성공
      } catch (error) {
        // 카카오톡으로 로그인 실패

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return null;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인

        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          return SocialLoginResult(token: token.accessToken);
          // 카카오계정으로 로그인 성공
        } catch (error) {
          return null;
          // 카카오계정으로 로그인 실패
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        return SocialLoginResult(token: token.accessToken);
        // 카카오계정으로 로그인 성공
      } catch (error) {
        return null;
        // 카카오계정으로 로그인 실패
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
