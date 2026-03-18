import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/use_case/setting_nickname_use_case.dart';
import 'package:knittda/src/presentation/mypage_setting_nickname/mypage_setting_nickname_event.dart';
import 'package:knittda/src/presentation/mypage_setting_nickname/mypage_setting_nickname_state.dart';
import 'package:knittda/src/presentation/mypage_setting_nickname/mypage_setting_nickname_ui_event.dart';

class MypageSettingNicknameViewModel extends ChangeNotifier {
  final SettingNicknameUseCase _settingNicknameUseCase;

  MypageSettingNicknameState _state = MypageSettingNicknameState(
    isLoading: false,
    user: null,
  );

  MypageSettingNicknameState get state => _state;

  final _eventController = StreamController<MypageSettingNicknameUiEvent>();

  Stream<MypageSettingNicknameUiEvent> get eventStream =>
      _eventController.stream;

  MypageSettingNicknameViewModel(
    this._settingNicknameUseCase, {
    required User user,
  }) {
    _state = state.copyWith(user: user);
  }

  Future<void> onEvent(MypageSettingNicknameEvent event) async {
    switch (event) {
      case SettingNickname(:final nickname):
        await _settingNickname(nickname);
    }
  }

  Future<void> _settingNickname(String nickname) async {
    if (state.isLoading) {
      return;
    }

    _state = state.copyWith(isLoading: true);
    notifyListeners();

    _state = state.copyWith(user: state.user!.copyWith(nickname: nickname));

    final Result<User?> result = await _settingNicknameUseCase(state.user!);

    switch (result) {
      case Success():
        _eventController.add(MypageSettingNicknameUiEvent.setNickname());

      case Error():
        _eventController.add(
          MypageSettingNicknameUiEvent.showSnackBar('닉네임 변경에 실패했어요. 다시 시도해주세요.'),
        );
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}
