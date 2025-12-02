import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_login_result.freezed.dart';

@freezed
abstract class SocialLoginResult with _$SocialLoginResult {
  factory SocialLoginResult({required String token, String? name}) =
      _SocialLoginResult;
}
