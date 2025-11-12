import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knittda/src/data/data_sources/social_login.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialLoginApple implements SocialLogin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<String?> login() async {
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


      // Firebase에 Apple credential 생성
      // Note: signInWithProvider는 web 전용이므로, mobile에서는 signInWithCredential 사용
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      print('[Apple Login] Signing in with Firebase...');
      // Firebase로 로그인 (mobile에서는 signInWithCredential 사용)
      final userCredential = await _auth.signInWithCredential(oauthCredential);

      // Firebase User 데이터 로깅
      final firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        print('[Apple Login] Firebase User data:');
        print('  - UID: ${firebaseUser.uid}');
        print('  - Email: ${firebaseUser.email ?? "null"}');
        print('  - Display Name: ${firebaseUser.displayName ?? "null"}');
        print('  - Photo URL: ${firebaseUser.photoURL ?? "null"}');
        print('  - Is New User: ${userCredential.additionalUserInfo?.isNewUser ?? "unknown"}');
      }

      // idToken 가져오기 (서버로 전송할 Firebase idToken)
      print('[Apple Login] Getting Firebase idToken...');
      final idToken = await firebaseUser?.getIdToken();
      
      if (idToken == null) {
        print('[Apple Login] ERROR: Firebase idToken is null');
        return null;
      }

      print('[Apple Login] Firebase idToken obtained (length: ${idToken.length})');
      print('[Apple Login] Successfully completed Apple login flow');
      
      return idToken;
    } catch (e, stackTrace) {
      print('[Apple Login] ERROR: $e');
      print('[Apple Login] Stack trace: $stackTrace');
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

