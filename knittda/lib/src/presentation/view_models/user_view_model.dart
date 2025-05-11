import 'package:flutter/material.dart';
import 'auth_view_model.dart';

class UserViewModel extends ChangeNotifier {
  AuthViewModel _authViewModel;

  UserViewModel(this._authViewModel);

  void update(AuthViewModel authViewModel) {
    _authViewModel = authViewModel;
    notifyListeners();
  }

  bool get isReady =>
      _authViewModel.status == AuthStatus.authenticated &&
          _authViewModel.user != null;

  String get nickname => _authViewModel.user?.nickname ?? '이름 없음';

  String get email => _authViewModel.user?.email ?? '이메일 없음';

  ImageProvider? get profileImage {
    final url = _authViewModel.user?.profileImageUrl;
    return url != null ? NetworkImage(url) : null;
  }
}