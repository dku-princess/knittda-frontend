import 'package:flutter/material.dart';

import 'package:knittda/src/services/social_login.dart';

import 'package:knittda/src/models/user_model.dart';

import 'package:knittda/src/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final SocialLogin _socialLogin;
  final AuthRepository _authRepository;

  UserModel? user;

  LoginViewModel(this._socialLogin, this._authRepository);

  Future<bool> login() async {
    final token = await _socialLogin.login();
    if (token == null) return false;

    user = await _authRepository.authenticateWithKakao(token);
    if (user == null) return false;

    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    await _socialLogin.logout();
    user = null;
    notifyListeners();
  }
}
