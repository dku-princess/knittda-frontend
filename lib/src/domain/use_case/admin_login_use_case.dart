import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';
import 'package:knittda/src/domain/repository/report_api_repository.dart';
import 'package:knittda/src/domain/model/user.dart';

class AdminLoginUseCase {
  final AuthenticationRepository _authenticationRepository;
  final ReportApiRepository _reportApiRepository;

  AdminLoginUseCase(this._authenticationRepository, this._reportApiRepository);

  Future<Result<void>> call() async {
    final storedUser = await _authenticationRepository.getStoredUser();

    final Result<User> result = await _authenticationRepository.getAuthAdmin();

    if (result is Error<User>) {
      return Result.error(result.e);
    }

    final newUser = (result as Success<User>).data;

    if (storedUser != null && storedUser.id != newUser.id) {
      await _reportApiRepository.clearReport();
    }

    return Result.success(null);
  }
}