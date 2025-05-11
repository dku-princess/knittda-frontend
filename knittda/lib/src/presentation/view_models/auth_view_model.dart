import 'package:flutter/material.dart';

import 'package:knittda/src/data/datasources/social_login.dart';
import 'package:knittda/src/core/storage/token_storage.dart';

import 'package:knittda/src/data/models/user_model.dart';

import 'package:knittda/src/data/repositories/auth_repository.dart';

enum AuthStatus { loading, authenticated, unauthenticated }

class AuthViewModel extends ChangeNotifier {
  final SocialLogin _socialLogin;
  final AuthRepository _authRepository;
  final TokenStorage _tokenStorage;

  String? jwt;
  UserModel? user;

//현재 인증 상태
  AuthStatus status = AuthStatus.loading;

  AuthViewModel(
      this._socialLogin,
      this._authRepository,
      this._tokenStorage,
      ) {
    _init(); //생성되자마자 자동 로그인 시도
  }

  Future<void> _init() async {
    await tryAutoLogin();
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
      status = AuthStatus.authenticated;
      notifyListeners();

      // 디바이스에 저장
      await _tokenStorage.save(jwt!);

      debugPrint('카카오 로그인 성공');

      return true;
    } catch (e) {
      status = AuthStatus.unauthenticated;
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
        status = AuthStatus.authenticated;
        debugPrint('사용자 정보 조회 성공');
        debugPrint(jwt);
      } catch(e) {
        status = AuthStatus.unauthenticated;
        debugPrint('사용자 정보 조회 실패: $e');
      }
    } else {
      status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _socialLogin.logout();
    await _tokenStorage.delete();
    jwt = null;
    user = null;
    status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
