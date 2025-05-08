import 'package:flutter/material.dart';

import 'package:knittda/src/services/social_login.dart';

import 'package:knittda/src/models/user_model.dart';

import 'package:knittda/src/repositories/auth_repository.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthViewModel extends ChangeNotifier {
  final SocialLogin _socialLogin;
  final AuthRepository _authRepository;

  UserModel? user;
  String? accessToken;
  String? refreshToken;

  AuthViewModel(this._socialLogin, this._authRepository);

  //토큰 업데이트 함수
  update({
    String? refreshToken,
    String? accessToken,
  }) {
    if (refreshToken != null) {
      this.refreshToken = refreshToken;
    }

    if (accessToken != null) {
      this.accessToken = accessToken;
    }

    notifyListeners();
  }

  Future<bool> loginWithKakao() async {
    final token = await _socialLogin.login();
    if (token == null) return false;

    final res = await _authRepository.loginWithKakao(token);

    update(
      refreshToken: res.refreshToken,
      accessToken: res.accessToken,
    );

    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    await _socialLogin.logout();
    accessToken = null;
    refreshToken = null;
    user = null;
    notifyListeners();
  }
}
