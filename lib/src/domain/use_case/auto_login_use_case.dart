import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';
import 'package:knittda/src/domain/repository/report_api_repository.dart';

class AutoLoginUseCase {
  final AuthenticationRepository _authenticationRepository;
  final ReportApiRepository _reportApiRepository;

  AutoLoginUseCase(this._authenticationRepository, this._reportApiRepository);

  Future<Result<void>> call() async {
    final token = await _authenticationRepository.getStoredToken();

    if (token == null) {
      return Result.error('no_token');
    }

    final storedUser = await _authenticationRepository.getStoredUser();
    final result = await _authenticationRepository.getAuthMe();

    if (result is Success<User>) {
      final newUser = result.data;

      if (storedUser != null && storedUser.id != newUser.id) {
        await _reportApiRepository.clearReport();
      }

      return Result.success(null);
    } else {
      final error = (result as Error).e;
      await _authenticationRepository.clearLocalAuth();
      await _reportApiRepository.clearReport();
      return Result.error('token_invalid');
    }
  }
}
