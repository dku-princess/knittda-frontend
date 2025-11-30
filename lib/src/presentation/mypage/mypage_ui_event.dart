import 'package:freezed_annotation/freezed_annotation.dart';

part 'mypage_ui_event.freezed.dart';

@freezed
sealed class MypageUiEvent with _$MypageUiEvent {
  const factory MypageUiEvent.completed() = Completed;
  const factory MypageUiEvent.showSnackBar(String message) = ShowSnackBar;
}
