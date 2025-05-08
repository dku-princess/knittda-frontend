import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'package:knittda/src/services/social_login.dart';

import 'package:flutter/material.dart';

class KaKaoLogin implements SocialLogin {
  @override
  Future<String?> login() async {
    // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        debugPrint('카카오톡으로 로그인 성공 ${token.accessToken}');
        return token.accessToken;
      } catch (error) {
        debugPrint('카카오톡으로 로그인 실패 $error');
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          debugPrint('카카오톡으로 로그인 성공 ${token.accessToken}');
          return token.accessToken;
        } catch (error) {
          debugPrint('카카오계정으로 로그인 실패 $error');
          return null;
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        debugPrint('카카오톡으로 로그인 성공 ${token.accessToken}');
        return token.accessToken;
      } catch (error) {
        debugPrint('카카오계정으로 로그인 실패 $error');
        return null;
      }
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