import 'package:flutter/material.dart';
import 'package:knittda/src/core/storage/report_local_data_source.dart';

import 'package:knittda/src/data/data_sources/social_login.dart';
import 'package:knittda/src/data/data_sources/kakao_login.dart';
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

  AuthViewModel(
      this._socialLogin,
      this._authRepo,
      this._storage,
      ) {
    _init(); // 생성 시 자동 로그인 시도
  }

  //getter — 외부에선 읽기 전용
  UserModel? get user => _user;
  AuthStatus get status => _status;

  Future<void> _init() async {
    await tryAutoLogin();
  }

  Future<bool> loginWithKakao() async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      final token = await _socialLogin.login();

      //토큰이 없으면 즉시 상태 복구
      if (token == null) {
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return false;
      }

      final result = await _authRepo.loginWithKakao(token);

      final prevUserId = await _storage.readUserId();
      final newUserId  = result.user.id.toString();

      if (prevUserId != null && prevUserId != newUserId) {
        await ReportLocalDataSource().clear();
      }

      _jwt   = result.jwt;
      _user  = result.user;
      _status = AuthStatus.authenticated;

      await _storage.save(_jwt!);
      await _storage.saveUserId(newUserId);

      notifyListeners();
      //debugPrint('카카오 로그인 성공');
      return true;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      //debugPrint('카카오 로그인 실패: $e');
      return false;
    }
  }

  // 웹 로그인 전용 메서드 (iPhone mini 등에서 사용)
  Future<bool> loginWithKakaoWeb() async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      // KaKaoLogin의 웹 로그인 전용 메서드 사용
      final token = await (_socialLogin as KaKaoLogin).loginWithWebOnly();

      if (token == null) {
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return false;
      }

      final result = await _authRepo.loginWithKakao(token);

      final prevUserId = await _storage.readUserId();
      final newUserId  = result.user.id.toString();

      if (prevUserId != null && prevUserId != newUserId) {
        await ReportLocalDataSource().clear();
      }

      _jwt   = result.jwt;
      _user  = result.user;
      _status = AuthStatus.authenticated;

      await _storage.save(_jwt!);
      await _storage.saveUserId(newUserId);

      notifyListeners();
      //debugPrint('카카오 웹 로그인 성공');
      return true;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      //debugPrint('카카오 웹 로그인 실패: $e');
      return false;
    }
  }

  Future<void> tryAutoLogin() async {
    try {
      _jwt = await _storage.read();
      if (_jwt == null) throw 'no token';

      final result = await _authRepo.me();
      _user   = result.user;
      _status = AuthStatus.authenticated;

      //debugPrint('자동 로그인 성공');
    } catch (_) {
      _jwt    = null;
      _user   = null;
      _status = AuthStatus.unauthenticated;

      await _storage.delete();
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

  Future<bool> signout() async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      // 1) 서버 계정 삭제
      final backendOk = await _authRepo.signout();

      // 2) 카카오 연결 해제
      final kakaoOk = await _socialLogin.unlink();

      if (!backendOk || !kakaoOk) throw Exception('탈퇴 처리 실패');

      // 3) 로컬 정리
      await ReportLocalDataSource().clear();
      await _storage.delete();
      await _storage.deleteUserId();

      _jwt  = null;
      _user = null;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return true;

    } catch (e) {
      //실패하면 로그아웃 상태로 간다
      await ReportLocalDataSource().clear();
      await _storage.delete();
      await _storage.deleteUserId();

      _jwt = null;
      _user = null;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }
}