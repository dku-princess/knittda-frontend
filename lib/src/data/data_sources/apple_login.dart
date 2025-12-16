import 'dart:io';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:knittda/src/data/data_sources/social_login.dart';

class AppleLogin implements SocialLogin {
  @override
  Future<String?> login() async {
    // iOS에서만 Apple 로그인 지원
    if (!Platform.isIOS) {
      return null;
    }

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Apple 로그인은 identityToken을 사용
      // 서버에서 검증할 수 있도록 identityToken을 반환
      return credential.identityToken;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<bool> logout() async {
    // Apple 로그인은 앱 레벨에서 로그아웃이 없음
    // 사용자가 iOS 설정에서 연결 해제해야 함
    return true;
  }

  @override
  Future<bool> unlink() async {
    // Apple 로그인은 앱 레벨에서 연결 해제가 없음
    // 사용자가 iOS 설정에서 연결 해제해야 함
    return true;
  }
}
