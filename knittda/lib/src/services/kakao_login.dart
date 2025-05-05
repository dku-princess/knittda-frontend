import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'package:knittda/src/services/social_login.dart';

class KaKaoLogin implements SocialLogin {
  @override
  Future<String?> login() async {
    try {
      OAuthToken token;
      if (await isKakaoTalkInstalled()) {
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }
      return token.accessToken;
    } catch (error) {
        print('카카오톡으로 로그인 실패 $error');
        return null;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.logout();
      print('연결 끊기 성공, SDK에서 토큰 폐기');
      return true;
    } catch (error) {
      print('연결 끊기 실패 $error');
      return false;
    }
  }
}