import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/util/social_login_type.dart';

part 'login_event.freezed.dart';

@freezed
sealed class LoginEvent with _$LoginEvent {
  const factory LoginEvent.socialLogin({required SocialLoginType type}) =
      SocialLogin;
}
