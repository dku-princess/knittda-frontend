import 'package:flutter/material.dart';
import 'auth_view_model.dart';

class UserViewModel extends ChangeNotifier {
  AuthViewModel _auth;

  UserViewModel(this._auth);

  void update(AuthViewModel auth) => _auth = auth;

  bool get isReady =>
      _auth.status == AuthStatus.authenticated && _auth.user != null;

  String get nickname => _auth.user?.nickname ?? '이름 없음';
  String get email    => _auth.user?.email    ?? '이메일 없음';

  ImageProvider? get profileImage {
    final url = _auth.user?.profileImageUrl;
    return url != null ? NetworkImage(url) : null;
  }
}