import 'package:flutter/material.dart';

import 'package:knittda/src/services/social_login.dart';

import 'package:knittda/src/models/user_model.dart';

import 'package:knittda/src/repositories/auth_repository.dart';

import '../shared/token_storage.dart';

class AuthViewModel extends ChangeNotifier {
  final SocialLogin _socialLogin;
  final AuthRepository _authRepository;
  final TokenStorage _tokenStorage;

  String? jwt;
  UserModel? user;

  /// 첫 초기화(자동 로그인 시도)가 끝났는지 여부
  bool _initialized = false;
  bool get initialized => _initialized;

  AuthViewModel(
      this._socialLogin,
      this._authRepository,
      this._tokenStorage,
      ) {
    // 생성자에서 비동기로 자동 로그인 시도
    _init();
  }

  Future<void> _init() async {
    await tryAutoLogin();   // 토큰이 있으면 사용자 정보까지 조회
    _initialized = true;    // 최초 초기화 끝
    notifyListeners();
  }

  Future<bool> loginWithKakao() async {
    try {
      final token = await _socialLogin.login();
      if (token == null) {
        return false; // 소셜 로그인 실패
      }

      // 서버요청
      final result = await _authRepository.loginWithKakao(token);

      // 상태갱신
      jwt  = result.jwt;
      user = result.user;
      notifyListeners();

      // 디바이스에 저장
      await _tokenStorage.save(jwt!);

      debugPrint('카카오 로그인 성공');

      return true;
    } catch (e) {
      debugPrint('카카오 로그인 실패: $e');
      return false;
    }
  }

  Future<void> tryAutoLogin() async {
    jwt = await _tokenStorage.read();
    if(jwt != null){
      try {
        final result = await _authRepository.me(jwt!);
        user = result.user;
        debugPrint('사용자 정보 조회 성공');
      } catch(e) {
        debugPrint('사용자 정보 조회 실패: $e');
      }
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _socialLogin.logout();
    jwt = null;
    user = null;
    await _tokenStorage.delete();
    notifyListeners();
  }
}
