import 'package:freezed_annotation/freezed_annotation.dart';

part 'mypage_setting_nickname_event.freezed.dart';

@freezed
sealed class MypageSettingNicknameEvent with _$MypageSettingNicknameEvent {
  const factory MypageSettingNicknameEvent.settingNickname(String nickname) = SettingNickname;
}