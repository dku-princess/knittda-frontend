abstract class SocialLogin {
  Future<String?> login();

  Future<bool> logout();

  Future<bool> unlink();
}