import 'package:knittda/src/data/data_sources/social_login.dart';
import 'package:knittda/src/data/data_sources/social_login_result.dart';

class SocialLoginAppleDummy implements SocialLogin {
  @override
  Future<SocialLoginResult?> login() async {
    return null;
  }

  @override
  Future<bool> logout() async {
    return true;
  }

  @override
  Future<bool> unlink() async {
    return true;
  }
}
