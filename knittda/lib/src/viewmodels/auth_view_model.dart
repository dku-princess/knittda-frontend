import 'package:flutter/material.dart';

import 'package:knittda/src/services/social_login.dart';

import 'package:knittda/src/models/user_model.dart';

import 'package:knittda/src/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final SocialLogin _socialLogin;
  final AuthRepository _authRepository;

  UserModel? user;
  String? jwt;

  AuthViewModel(this._socialLogin, this._authRepository);

  Future<bool> loginWithKakao() async {
    try {
      final token = await _socialLogin.login();
      if (token == null) {
        return false; // 소셜 로그인 실패
      }

      await _authRepository.loginWithKakao(token);

      notifyListeners();
      return true; // 로그인 성공
    } catch (e) {
      debugPrint('카카오 로그인 실패: $e');
      return false;
    }
  }

  Future<void> logout() async {
    await _socialLogin.logout();
    notifyListeners();
  }
}
