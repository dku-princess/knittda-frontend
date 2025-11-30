import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';
import 'package:knittda/src/domain/util/social_login_type.dart';

class LogoutUseCase {
  final AuthenticationRepository _authenticationRepository;

  LogoutUseCase(this._authenticationRepository);

  Future<Result<void>> call(SocialLoginType type) async {
    final result = await _authenticationRepository.socialLogout(type: type);

    await _authenticationRepository.clearLocalAuth();

    if (result is Error<bool>) {
      return Result.error(result.e);
    }

    return Result.success(null);
  }
}
