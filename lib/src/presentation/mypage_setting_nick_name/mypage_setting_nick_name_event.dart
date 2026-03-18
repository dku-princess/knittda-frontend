import 'package:freezed_annotation/freezed_annotation.dart';

part 'mypage_setting_nick_name_event.freezed.dart';

@freezed
sealed class MypageSettingNickNameEvent with _$MypageSettingNickNameEvent {
  const factory MypageSettingNickNameEvent.settingNickName(String nickName) = SettingNickName;
}