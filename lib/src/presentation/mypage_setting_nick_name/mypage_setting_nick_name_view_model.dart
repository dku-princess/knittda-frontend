import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/use_case/setting_nick_name_use_case.dart';
import 'package:knittda/src/presentation/mypage_setting_nick_name/mypage_setting_nick_name_event.dart';
import 'package:knittda/src/presentation/mypage_setting_nick_name/mypage_setting_nick_name_state.dart';
import 'package:knittda/src/presentation/mypage_setting_nick_name/mypage_setting_nick_name_ui_event.dart';

class MypageSettingNickNameViewModel extends ChangeNotifier {
  final SettingNickNameUseCase _settingNickNameUseCase;

  MypageSettingNickNameState _state = MypageSettingNickNameState(
    isLoading: false,
    user: null,
  );

  MypageSettingNickNameState get state => _state;

  final _eventController = StreamController<MypageSettingNickNameUiEvent>();

  Stream<MypageSettingNickNameUiEvent> get eventStream =>
      _eventController.stream;

  MypageSettingNickNameViewModel(
    this._settingNickNameUseCase, {
    required User user,
  }) {
    _state = state.copyWith(user: user);
  }

  Future<void> onEvent(MypageSettingNickNameEvent event) async {
    switch (event) {
      case SettingNickName(:final nickName):
        await _settingNickName(nickName);
    }
  }

  Future<void> _settingNickName(String nickName) async {
    if (state.isLoading) {
      return;
    }

    _state = state.copyWith(isLoading: true);
    notifyListeners();

    _state = state.copyWith(user: state.user!.copyWith(nickname: nickName));

    final Result<User?> result = await _settingNickNameUseCase(state.user!);

    switch (result) {
      case Success():
        _eventController.add(MypageSettingNickNameUiEvent.setNickName());

      case Error():
        _eventController.add(
          MypageSettingNickNameUiEvent.showSnackBar('닉네임 변경에 실패했어요. 다시 시도해주세요.'),
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
