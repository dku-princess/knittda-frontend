import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knittda/src/data/data_sources/social_login.dart';
import 'package:knittda/src/data/data_sources/social_login_result.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialLoginApple implements SocialLogin {
  FirebaseAuth get _auth => FirebaseAuth.instance;

  // Apple 로그인 결과 (토큰 + 이름) 반환
  @override
  Future<SocialLoginResult?> login() async {
    // iOS에서만 동작
    if (!Platform.isIOS) {
      return null;
    }

    try {
      // Apple Sign In 요청
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // 이름 정보 추출 (첫 로그인 시에만 제공됨)
      String? fullName;
      if (appleCredential.givenName != null ||
          appleCredential.familyName != null) {
        final parts = <String>[];
        if (appleCredential.givenName != null) {
          parts.add(appleCredential.givenName!);
        }
        if (appleCredential.familyName != null) {
          parts.add(appleCredential.familyName!);
        }
        fullName = parts.isNotEmpty ? parts.join(' ') : null;
      }

      // Firebase에 Apple credential 생성
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Firebase로 로그인
      final userCredential = await _auth.signInWithCredential(oauthCredential);
      final firebaseUser = userCredential.user;

      // idToken 가져오기 (서버로 전송할 Firebase idToken)
      final idToken = await firebaseUser?.getIdToken();

      if (idToken == null) {
        return null;
      }

      return SocialLoginResult(token: idToken, name: fullName);
    } catch (e) {
      print('Apple login error: $e');
      return null;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      print('Apple logout error: $e');
      return false;
    }
  }

  @override
  Future<bool> unlink() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Apple provider 연결 해제
        await user.unlink('apple.com');
        await _auth.signOut();
        return true;
      }
      return false;
    } catch (e) {
      print('Apple unlink error: $e');
      return false;
    }
  }
}
