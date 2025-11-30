import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';
import 'package:knittda/src/domain/repository/report_api_repository.dart';
import 'package:knittda/src/domain/util/social_login_type.dart';

class SignoutUseCase {
  final AuthenticationRepository _authenticationRepository;
  final ReportApiRepository _reportApiRepository;

  SignoutUseCase(this._authenticationRepository, this._reportApiRepository);

  Future<Result<void>> call(SocialLoginType type) async {
    final signoutResult = await _authenticationRepository.deleteAuthSignout();

    if (signoutResult is Error<void>) {
      await _authenticationRepository.clearLocalAuth();
      await _reportApiRepository.clearReport();
      return Result.error(signoutResult.e);
    }

    final unlinkResult = await _authenticationRepository.socialUnlink(
      type: type,
    );

    await _authenticationRepository.clearLocalAuth();
    await _reportApiRepository.clearReport();

    if (unlinkResult is Error<bool>) {
      return Result.error(unlinkResult.e);
    }

    return Result.success(null);
  }
}
