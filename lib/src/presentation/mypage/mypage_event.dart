import 'package:freezed_annotation/freezed_annotation.dart';

part 'mypage_event.freezed.dart';

@freezed
sealed class MypageEvent with _$MypageEvent {
  const factory MypageEvent.logout() = Logout;
  const factory MypageEvent.signout() = Signout;
}
