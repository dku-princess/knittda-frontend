import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:knittda/env.dart';

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

  // 웹 로그인 전용 메서드 (iOS 17+ 충돌 문제 해결)
  Future<String?> loginWithWebOnly() async {
    try {
      final clientId = Env.kakaoNativeAppKey;
      final redirectUri = 'kakao$clientId://oauth';

      final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
        'client_id': clientId,
        'redirect_uri': redirectUri,
        'response_type': 'code',
        'prompt': 'login', // 항상 로그인창 표시
      });

      // Safari에서 명시적으로 OAuth를 수행합니다.
      final result = await FlutterWebAuth.authenticate(
        url: url.toString(),
        callbackUrlScheme: 'kakao$clientId',
      );

      // 인증 코드 파싱
      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) {
        debugPrint('인증 코드를 받지 못했습니다');
        return null;
      }

      // 카카오 서버에서 OAuth 토큰을 받아옴
      OAuthToken token = await AuthApi.instance.issueAccessToken(authorizationCode: code);

      // 토큰 저장
      await TokenManagerProvider.instance.manager.setToken(token);
      
      debugPrint('웹 로그인 성공 ${token.accessToken}');
      return token.accessToken;
    } catch (error) {
      debugPrint('웹 로그인 실패 $error');
      return null;
    }
  }
}