import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/analytics_service.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/use_case/auto_login_use_case.dart';
import 'package:knittda/src/domain/use_case/get_user_use_case.dart';
import 'package:knittda/src/domain/use_case/social_login_use_case.dart';
import 'package:knittda/src/domain/util/social_login_type.dart';
import 'package:knittda/src/presentation/login/login_event.dart';
import 'package:knittda/src/presentation/login/login_state.dart';
import 'package:knittda/src/presentation/login/login_ui_event.dart';

class LoginViewModel extends ChangeNotifier {
  final AutoLoginUseCase _autoLoginUseCase;
  final SocialLoginUseCase _socialLoginUseCase;
  final GetUserUseCase _getUserUseCase;

  LoginState _state = LoginState(isLoading: false);

  LoginState get state => _state;

  final _eventController = StreamController<LoginUiEvent>();

  Stream<LoginUiEvent> get eventStream => _eventController.stream;

  // 동시에 실행 중인 로딩 작업 수 — 모두 완료돼야 isLoading = false
  int _pendingLoads = 0;
  bool _isSocialLoginInProgress = false;

  LoginViewModel(
    this._autoLoginUseCase,
    this._socialLoginUseCase,
    this._getUserUseCase,
  ) {
    _autoLogin();
  }

  // 로그인 성공 직후 GA4 user_id 설정. 화면 전환 지연 방지를 위해 fire-and-forget.
  // timeout으로 user stream이 emit 안 될 경우의 StreamSubscription 누수 방지.
  void _setUserIdAfterLogin() {
    _getUserUseCase
        .execute()
        .first
        .timeout(const Duration(seconds: 5))
        .then((user) => AnalyticsService.instance.setUserId(user.id.toString()))
        .catchError((_) {});
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
    _startLoading();

    try {
      final Result<void> result = await _autoLoginUseCase();

      switch (result) {
        case Success():
          _setUserIdAfterLogin();
          _eventController.add(LoginUiEvent.login());
        case Error():
          break;
      }
    } catch (_) {
    } finally {
      _stopLoading();
    }
  }

  Future<void> _socialLogin({required SocialLoginType type}) async {
    if (_isSocialLoginInProgress) return;
    _isSocialLoginInProgress = true;
    _startLoading();

    try {
      final Result<void> result = await _socialLoginUseCase(type);

      switch (result) {
        case Success():
          final provider = switch (type) {
            Kakao() => 'kakao',
            Apple() => 'apple',
          };
          AnalyticsService.instance.logLogin(provider);
          _setUserIdAfterLogin();
          _eventController.add(LoginUiEvent.login());
        case Error():
          _eventController.add(
            LoginUiEvent.showSnackBar('로그인에 실패했습니다. 다시 시도해주세요'),
          );
      }
    } catch (_) {
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
