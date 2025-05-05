import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'package:knittda/src/services/social_login.dart';

class KaKaoLogin implements SocialLogin {
  @override
  Future<bool> login() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        return true;

      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');
        return false;
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        return true;
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
        return false;
      }
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      print('연결 끊기 성공, SDK에서 토큰 폐기');
      return true;
    } catch (error) {
      print('연결 끊기 실패 $error');
      return false;
    }
  }
}