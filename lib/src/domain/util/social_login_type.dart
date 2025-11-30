import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_login_type.freezed.dart';

@freezed
sealed class SocialLoginType with _$SocialLoginType {
  const factory SocialLoginType.kakao() = Kakao;
  const factory SocialLoginType.apple() = Apple;
}