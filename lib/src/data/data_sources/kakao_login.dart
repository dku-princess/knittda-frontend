import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'package:knittda/src/data/data_sources/social_login.dart';

class KaKaoLogin implements SocialLogin {
  @override
  Future<String?> login() async {
    // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        //debugPrint('카카오톡으로 로그인 성공 ${token.accessToken}');
        return token.accessToken;
      } catch (error) {
        //debugPrint('카카오톡으로 로그인 실패 $error');
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          //debugPrint('카카오톡으로 로그인 성공 ${token.accessToken}');
          return token.accessToken;
        } catch (error) {
          //debugPrint('카카오계정으로 로그인 실패 $error');
          return null;
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        //debugPrint('카카오톡으로 로그인 성공 ${token.accessToken}');
        return token.accessToken;
      } catch (error) {
        //debugPrint('카카오계정으로 로그인 실패 $error');
        return null;
      }
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.logout();
      //debugPrint('연결 끊기 성공, SDK에서 토큰 폐기');
      return true;
    } catch (error) {
      //debugPrint('연결 끊기 실패 $error');
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

  // 웹 로그인 전용 메서드 (iPhone mini 등에서 사용)
  Future<String?> loginWithWebOnly() async {
    try {
      // 웹 로그인 창이 충분히 표시되도록 짧은 지연 추가
      await Future.delayed(const Duration(milliseconds: 500));
      
      // 웹 로그인은 항상 카카오계정으로 로그인 시도
      // 카카오톡이 설치되어 있어도 웹 로그인을 강제로 사용
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount(
        prompts: [Prompt.login], // 계정 선택 강제 옵션
      );
      //debugPrint('웹 로그인 성공 ${token.accessToken}');
      return token.accessToken;
    } catch (error) {
      //debugPrint('웹 로그인 실패 $error');
      return null;
    }
  }

}