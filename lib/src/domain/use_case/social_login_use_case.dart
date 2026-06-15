import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/data/data_sources/social_login_result.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';
import 'package:knittda/src/domain/util/social_login_type.dart';

class SocialLoginUseCase {
  final AuthenticationRepository _authenticationRepository;

  SocialLoginUseCase(this._authenticationRepository);

  Future<Result<void>> call(SocialLoginType type) async {
    final Result<SocialLoginResult> loginResult =
        await _authenticationRepository.socialLogin(type: type);

    if (loginResult is Error<SocialLoginResult>) {
      return Result.error(loginResult.e);
    }

    final social = (loginResult as Success<SocialLoginResult>).data;

    final Result<User> authResult = switch (type) {
      Kakao() => await _authenticationRepository.getAuthKakao(token: social.token),
      Apple() => await _authenticationRepository.getAuthApple(
        token: social.token,
        name: social.name ?? '',
      ),
    };

    if (authResult is Error<User>) {
      return Result.error(authResult.e);
    }

    return Result.success(null);
  }
}
