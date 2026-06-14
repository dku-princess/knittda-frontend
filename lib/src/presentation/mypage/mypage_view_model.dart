import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/use_case/get_user_use_case.dart';
import 'package:knittda/src/domain/use_case/logout_use_case.dart';
import 'package:knittda/src/domain/use_case/setting_profile_image_use_case.dart';
import 'package:knittda/src/domain/use_case/signout_use_case.dart';
import 'package:knittda/src/presentation/mypage/mypage_event.dart';
import 'package:knittda/src/presentation/mypage/mypage_state.dart';
import 'package:knittda/src/presentation/mypage/mypage_ui_event.dart';

class MypageViewModel extends ChangeNotifier {
  final LogoutUseCase _logoutUseCase;
  final SignoutUseCase _signoutUseCase;
  final SettingProfileImageUseCase _settingProfileImageUseCase;
  final GetUserUseCase _getUserUseCase;
  StreamSubscription? _streamSubscription;

  MypageState _state = MypageState(isLoading: false, user: null);

  MypageState get state => _state;

  final _eventController = StreamController<MypageUiEvent>();

  Stream<MypageUiEvent> get eventStream => _eventController.stream;

  MypageViewModel(
    this._logoutUseCase,
    this._signoutUseCase,
    this._settingProfileImageUseCase,
    this._getUserUseCase,
  ) {
    _streamSubscription = _getUserUseCase.execute().listen((user) {
      _state = state.copyWith(user: user);
      notifyListeners();
    });
  }

  Future<void> onEvent(MypageEvent event) async {
    switch (event) {
      case Logout():
        await _logout();
      case Signout():
        await _signout();
      case SettingProfileImage(:final file):
        await _settingProfileImage(file);
    }
  }

  Future<void> _settingProfileImage(XFile file) async {
    if (state.isLoading) {
      _eventController.add(
        MypageUiEvent.showSnackBar('이미지 업로드 중이에요. 잠시 후 다시 시도해주세요.'),
      );
      return;
    }

    _state = state.copyWith(isLoading: true, previewImage: file);
    notifyListeners();

    final Result<User?> result = await _settingProfileImageUseCase(file);

    switch (result) {
      case Success():
        _state = state.copyWith(isLoading: false, previewImage: null);
      case Error():
        _state = state.copyWith(isLoading: false, previewImage: null);
        _eventController.add(
          MypageUiEvent.showSnackBar('프로필 이미지 변경에 실패했어요. 다시 시도해주세요.'),
        );
    }

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

    await _logoutUseCase(user);

    _state = state.copyWith(isLoading: false, user: null);

    _eventController.add(MypageUiEvent.completed());
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
        _eventController.add(
          MypageUiEvent.showSnackBar('회원탈퇴에 실패했어요. 다시 시도해 주세요.'),
        );
        _eventController.add(MypageUiEvent.completed());
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _eventController.close();
    super.dispose();
  }
}
