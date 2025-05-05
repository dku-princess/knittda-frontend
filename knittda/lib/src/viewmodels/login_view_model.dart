import 'package:flutter/material.dart';

import 'package:knittda/src/services/social_login.dart';

import 'package:knittda/src/models/user_model.dart';

import 'package:knittda/src/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final SocialLogin _socialLogin;
  final AuthRepository _authRepository;

  UserModel? user;
  bool isLogined = false;

  LoginViewModel(this._socialLogin, this._authRepository);

  Future<bool> login() async {
    final token = await _socialLogin.login();
    if (token == null) return false;

    final fetchedUser = await _authRepository.authenticateWithKakao(token);
    if (fetchedUser == null) return false;

    user = fetchedUser;
    isLogined = true;
    notifyListeners();
    return true;
  }

  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
    notifyListeners();
  }
}
