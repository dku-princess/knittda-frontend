import 'package:flutter/foundation.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/data/data_sources/social_login_result.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';
import 'package:knittda/src/domain/util/social_login_type.dart';

class SocialLoginUseCase {
  final AuthenticationRepository _authenticationRepository;

  SocialLoginUseCase(this._authenticationRepository);

  Future<Result<void>> call(SocialLoginType type) async {
    debugPrint('[SocialLoginUseCase] 소셜 로그인 시작: $type');

    final Result<SocialLoginResult> loginResult =
        await _authenticationRepository.socialLogin(type: type);

    if (loginResult is Error<SocialLoginResult>) {
      debugPrint('[SocialLoginUseCase] 소셜 토큰 획득 실패: ${loginResult.e}');
      return Result.error(loginResult.e);
    }

    final social = (loginResult as Success<SocialLoginResult>).data;
    debugPrint('[SocialLoginUseCase] 소셜 토큰 획득 성공, 서버 인증 시작');

    final Result<User> authResult = switch (type) {
      Kakao() => await _authenticationRepository.getAuthKakao(token: social.token),
      Apple() => await _authenticationRepository.getAuthApple(
        token: social.token,
        name: social.name ?? '',
      ),
    };

    if (authResult is Error<User>) {
      debugPrint('[SocialLoginUseCase] 서버 인증 실패: ${authResult.e}');
      return Result.error(authResult.e);
    }

    debugPrint('[SocialLoginUseCase] 서버 인증 성공');
    return Result.success(null);
  }
}
