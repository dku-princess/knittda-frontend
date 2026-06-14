import 'dart:async';

import 'package:flutter/foundation.dart';
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

  // 동시에 실행 중인 로딩 작업 수 — 모두 완료돼야 isLoading = false
  int _pendingLoads = 0;
  bool _isSocialLoginInProgress = false;

  LoginViewModel(this._autoLoginUseCase, this._socialLoginUseCase) {
    _autoLogin();
  }

  Future<void> onEvent(LoginEvent event) async {
    switch (event) {
      case SocialLogin(:final type):
        await _socialLogin(type: type);
    }
  }

  void _startLoading() {
    _pendingLoads++;
    if (_state.isLoading == false) {
      _state = state.copyWith(isLoading: true);
      notifyListeners();
    }
  }

  void _stopLoading() {
    if (_pendingLoads > 0) _pendingLoads--;
    if (_pendingLoads == 0) {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> _autoLogin() async {
    debugPrint('[LoginViewModel] _autoLogin 시작');
    _startLoading();

    try {
      final Result<void> result = await _autoLoginUseCase();

      switch (result) {
        case Success():
          debugPrint('[LoginViewModel] 자동 로그인 성공, 홈 화면으로 이동');
          _eventController.add(LoginUiEvent.login());
        case Error(:final e):
          debugPrint('[LoginViewModel] 자동 로그인 실패: $e');
      }
    } catch (e, stackTrace) {
      debugPrint('[LoginViewModel] _autoLogin 예외 발생: $e');
      debugPrint('[LoginViewModel] $stackTrace');
    } finally {
      debugPrint('[LoginViewModel] _autoLogin 종료, isLoading 감소');
      _stopLoading();
    }
  }

  Future<void> _socialLogin({required SocialLoginType type}) async {
    if (_isSocialLoginInProgress) {
      debugPrint('[LoginViewModel] 소셜 로그인 이미 진행 중, 중복 요청 무시');
      return;
    }
    debugPrint('[LoginViewModel] _socialLogin 시작: $type');
    _isSocialLoginInProgress = true;
    _startLoading();

    try {
      final Result<void> result = await _socialLoginUseCase(type);

      switch (result) {
        case Success():
          debugPrint('[LoginViewModel] 로그인 성공, 홈 화면으로 이동');
          _eventController.add(LoginUiEvent.login());
        case Error(:final e):
          debugPrint('[LoginViewModel] 로그인 실패: $e');
          _eventController.add(
            LoginUiEvent.showSnackBar('로그인에 실패했습니다. 다시 시도해주세요'),
          );
      }
    } catch (e, stackTrace) {
      debugPrint('[LoginViewModel] _socialLogin 예외 발생: $e');
      debugPrint('[LoginViewModel] $stackTrace');
      _eventController.add(
        LoginUiEvent.showSnackBar('로그인에 실패했습니다. 다시 시도해주세요'),
      );
    } finally {
      _isSocialLoginInProgress = false;
      _stopLoading();
    }
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}
