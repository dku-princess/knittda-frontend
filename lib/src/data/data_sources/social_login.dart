import 'package:knittda/src/data/data_sources/social_login_result.dart';

abstract class SocialLogin {
  Future<SocialLoginResult?> login();

  Future<bool> logout();

  Future<bool> unlink();
}