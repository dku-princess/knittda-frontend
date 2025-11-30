import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/data/data_sources/social_login_result.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';
import 'package:knittda/src/domain/repository/report_api_repository.dart';
import 'package:knittda/src/domain/util/social_login_type.dart';

class SocialLoginUseCase {
  final AuthenticationRepository _authenticationRepository;
  final ReportApiRepository _reportApiRepository;

  SocialLoginUseCase(this._authenticationRepository, this._reportApiRepository);

  Future<Result<void>> call(SocialLoginType type) async {
    final storedUser = await _authenticationRepository.getStoredUser();

    final Result<SocialLoginResult> loginResult =
        await _authenticationRepository.socialLogin(type: type);

    if (loginResult is Error<SocialLoginResult>) {
      return Result.error(loginResult.e);
    }

    final social = (loginResult as Success<SocialLoginResult>).data;
    final token = social.token;

    final Result<User> authResult = switch (type) {
      Kakao() => await _authenticationRepository.getAuthKakao(token: token),
      Apple() => await _authenticationRepository.getAuthApple(
        token: token,
        name: social.name ?? '',
      ),
    };

    if (authResult is Error<User>) {
      return Result.error(authResult.e);
    }

    final newUser = (authResult as Success<User>).data;

    if (storedUser != null && storedUser.id != newUser.id) {
      await _reportApiRepository.clearReport();
    }

    return Result.success(null);
  }
}
