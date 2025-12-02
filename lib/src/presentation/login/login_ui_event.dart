import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_ui_event.freezed.dart';

@freezed
sealed class LoginUiEvent with _$LoginUiEvent {
  const factory LoginUiEvent.login() = Login;
  const factory LoginUiEvent.showSnackBar(String message) = ShowSnackBar;
}
