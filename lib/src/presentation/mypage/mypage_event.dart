import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'mypage_event.freezed.dart';

@freezed
sealed class MypageEvent with _$MypageEvent {
  const factory MypageEvent.logout() = Logout;
  const factory MypageEvent.signout() = Signout;
  const factory MypageEvent.settingProfileImage(XFile file) = SettingProfileImage;
}
