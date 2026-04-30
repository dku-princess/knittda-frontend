import 'package:freezed_annotation/freezed_annotation.dart';

part 'mypage_setting_nickname_ui_event.freezed.dart';

@freezed
sealed class MypageSettingNicknameUiEvent with _$MypageSettingNicknameUiEvent {
  const factory MypageSettingNicknameUiEvent.showSnackBar(String message) = ShowSnackBar;
  const factory MypageSettingNicknameUiEvent.setNickname() = SetNickname;
}