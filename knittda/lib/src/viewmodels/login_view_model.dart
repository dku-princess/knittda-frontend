import 'package:flutter/material.dart';

import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'package:knittda/src/services/social_login.dart';

class LoginViewModel extends ChangeNotifier {
  final SocialLogin _socialLogin;
  bool isLogined = false;
  User? user;

  LoginViewModel(this._socialLogin);

  Future<bool> login() async {
    isLogined = await _socialLogin.login();
    if (isLogined) {
      user = await UserApi.instance.me();
      notifyListeners();
      return true;
    }
    return false;
  }

  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
    notifyListeners();
  }
}