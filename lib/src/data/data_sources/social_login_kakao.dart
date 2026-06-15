import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:knittda/src/data/data_sources/social_login.dart';
import 'package:knittda/src/data/data_sources/social_login_result.dart';

class SocialLoginKakao implements SocialLogin {
  @override
  Future<SocialLoginResult?> login() async {
    final kakaoTalkInstalled = await isKakaoTalkInstalled();

    if (kakaoTalkInstalled) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        return SocialLoginResult(token: token.accessToken);
      } catch (error) {
        if (error is PlatformException && error.code == 'CANCELED') {
          return null;
        }

        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          return SocialLoginResult(token: token.accessToken);
        } catch (error) {
          return null;
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        return SocialLoginResult(token: token.accessToken);
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
}
