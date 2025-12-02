import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/use_case/get_stored_user_use_case.dart';
import 'package:knittda/src/domain/use_case/logout_use_case.dart';
import 'package:knittda/src/domain/use_case/signout_use_case.dart';
import 'package:knittda/src/presentation/mypage/mypage_event.dart';
import 'package:knittda/src/presentation/mypage/mypage_state.dart';
import 'package:knittda/src/presentation/mypage/mypage_ui_event.dart';

class MypageViewModel extends ChangeNotifier {
  final LogoutUseCase _logoutUseCase;
  final SignoutUseCase _signoutUseCase;
  final GetStoredUserUseCase _getStoredUserUseCase;

  MypageState _state = MypageState(isLoading: false, user: null);

  MypageState get state => _state;

  final _eventController = StreamController<MypageUiEvent>();

  Stream<MypageUiEvent> get eventStream => _eventController.stream;

  MypageViewModel(
    this._logoutUseCase,
    this._signoutUseCase,
    this._getStoredUserUseCase,
  ) {
    _loadUser();
  }

  Future<void> onEvent(MypageEvent event) async {
    switch (event) {
      case Logout():
        await _logout();
      case Signout():
        await _signout();
    }
  }

  Future<void> _loadUser() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final Result<User?> result = await _getStoredUserUseCase();

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(user: data);
      case Error():
        _state = state.copyWith(user: null);
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> _logout() async {
    if (state.isLoading) return;

    final user = state.user;

    if (user == null) {
      _eventController.add(const MypageUiEvent.completed());
      return;
    }

    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final Result<void> result = await _logoutUseCase(user);

    _state = state.copyWith(isLoading: false, user: null);

    switch (result) {
      case Success():
        _eventController.add(MypageUiEvent.completed());
      case Error():
        _eventController.add(MypageUiEvent.showSnackBar('로그아웃 중 오류가 발생했습니다.'));
        _eventController.add(MypageUiEvent.completed());
    }
  }

  Future<void> _signout() async {
    if (state.isLoading) return;

    final user = state.user;

    if (user == null) {
      _eventController.add(const MypageUiEvent.completed());
      return;
    }

    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final Result<void> result = await _signoutUseCase(user);

    _state = state.copyWith(isLoading: false, user: null);

    switch (result) {
      case Success():
        _eventController.add(MypageUiEvent.completed());
      case Error():
        _eventController.add(MypageUiEvent.showSnackBar('회원탈퇴 중 오류가 발생했습니다.'));
        _eventController.add(MypageUiEvent.completed());
    }
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}
