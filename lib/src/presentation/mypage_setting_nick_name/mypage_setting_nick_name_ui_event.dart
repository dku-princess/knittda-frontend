import 'package:freezed_annotation/freezed_annotation.dart';

part 'mypage_setting_nick_name_ui_event.freezed.dart';

@freezed
sealed class MypageSettingNickNameUiEvent with _$MypageSettingNickNameUiEvent {
  const factory MypageSettingNickNameUiEvent.showSnackBar(String message) = ShowSnackBar;
  const factory MypageSettingNickNameUiEvent.setNickName() = SetNickName;
}