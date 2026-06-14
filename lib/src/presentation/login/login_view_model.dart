import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/use_case/auto_login_use_case.dart';
import 'package:knittda/src/domain/use_case/social_login_use_case.dart';
import 'package:knittda/src/domain/util/social_login_type.dart';
import 'package:knittda/src/presentation/login/login_event.dart';
import 'package:knittda/src/presentation/login/login_state.dart';
import 'package:knittda/src/presentation/login/login_ui_event.dart';

class LoginViewModel extends ChangeNotifier {
  final AutoLoginUseCase _autoLoginUseCase;
  final SocialLoginUseCase _socialLoginUseCase;

  LoginState _state = LoginState(isLoading: false);

  LoginState get state => _state;

  final _eventController = StreamController<LoginUiEvent>();

  Stream<LoginUiEvent> get eventStream => _eventController.stream;

  LoginViewModel(this._autoLoginUseCase, this._socialLoginUseCase) {
    _autoLogin();
  }

  Future<void> onEvent(LoginEvent event) async {
    switch (event) {
      case SocialLogin(:final type):
        await _socialLogin(type: type);
    }
  }

  Future<void> _autoLogin() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final Result<void> result = await _autoLoginUseCase();

      switch (result) {
        case Success():
          _eventController.add(LoginUiEvent.login());
        case Error():
          break;
      }
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> _socialLogin({required SocialLoginType type}) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final Result<void> result = await _socialLoginUseCase(type);

      switch (result) {
        case Success():
          _eventController.add(LoginUiEvent.login());
        case Error():
          _eventController.add(
            LoginUiEvent.showSnackBar('로그인에 실패했습니다. 다시 시도해주세요'),
          );
      }
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}
