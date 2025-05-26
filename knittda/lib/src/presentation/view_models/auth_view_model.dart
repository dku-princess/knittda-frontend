import 'package:flutter/material.dart';

import 'package:knittda/src/data/datasources/social_login.dart';
import 'package:knittda/src/core/storage/token_storage.dart';

import 'package:knittda/src/data/models/user_model.dart';

import 'package:knittda/src/data/repositories/auth_repository.dart';

//import 'package:flutter/foundation.dart';

enum AuthStatus { loading, authenticated, unauthenticated }

class AuthViewModel extends ChangeNotifier {
  final SocialLogin _socialLogin;
  final AuthRepository _authRepo;
  final TokenStorage _storage;

  String? _jwt;
  UserModel? _user;
  AuthStatus _status = AuthStatus.loading;

  AuthViewModel(this._socialLogin, this._authRepo, this._storage) {
    _init(); // 생성 직후 자동 로그인 시도
  }

  //getter — 외부에선 읽기 전용
  String? get jwt => _jwt;
  UserModel? get user => _user;
  AuthStatus get status => _status;

  Future<void> _init() async {
    await tryAutoLogin();
  }

  Future<bool> loginWithKakao() async {
    try {
      final token = await _socialLogin.login();
      if (token == null) return false;

      final result = await _authRepo.loginWithKakao(token);

      _jwt   = result.jwt;
      _user  = result.user;
      _status = AuthStatus.authenticated;
      await _storage.save(_jwt!);

      notifyListeners();
      debugPrint('카카오 로그인 성공');
      return true;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      debugPrint('카카오 로그인 실패: $e');
      return false;
    }
  }

  Future<void> tryAutoLogin() async {
    try {
      _jwt = await _storage.read();
      if (_jwt == null) throw 'no token';

      final result = await _authRepo.me(_jwt!);
      _user   = result.user;
      _status = AuthStatus.authenticated;
      debugPrint('자동 로그인 성공');
    } catch (_) {
      _jwt    = null;
      _user   = null;
      _status = AuthStatus.unauthenticated;
      debugPrint('자동 로그인 실패');
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _socialLogin.logout();
    await _storage.delete();

    _jwt    = null;
    _user   = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}