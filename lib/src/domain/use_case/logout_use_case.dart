import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';
import 'package:knittda/src/domain/repository/report_api_repository.dart';
import 'package:knittda/src/domain/util/social_login_type.dart';

class LogoutUseCase {
  final AuthenticationRepository _authenticationRepository;
  final ReportApiRepository _reportApiRepository;

  LogoutUseCase(this._authenticationRepository, this._reportApiRepository);

  Future<Result<void>> call(User user) async {
    SocialLoginType? type;

    if (user.kakaoId != null) {
      type = const Kakao();
    } else if (user.appleId != null) {
      type = const Apple();
    }

    if (type != null) {
      await _authenticationRepository.socialLogout(type: type);
    }

    await _authenticationRepository.clearLocalAuth();

    await _reportApiRepository.clearReport();

    return Result.success(null);
  }
}
