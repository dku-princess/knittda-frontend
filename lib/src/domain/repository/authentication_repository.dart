import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/data/data_sources/social_login_result.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/util/social_login_type.dart';

abstract class AuthenticationRepository {
  Future<Result<User>> putNickName(User user);
  Future<Result<User>> postProfileImage(XFile file);
  Future<Result<User>> getAuthMe();
  Future<Result<User>> getAuthKakao({required String token});
  Future<Result<User>> getAuthApple({required String token, required String name});
  Future<Result<void>> deleteAuthSignout();

  Future<Result<SocialLoginResult>> socialLogin({required SocialLoginType type});
  Future<Result<bool>> socialLogout({required SocialLoginType type});
  Future<Result<bool>> socialUnlink({required SocialLoginType type});

  Future<String?> getStoredToken();
  Future<User?> getStoredUser();
  Future<void> clearLocalAuth();
}