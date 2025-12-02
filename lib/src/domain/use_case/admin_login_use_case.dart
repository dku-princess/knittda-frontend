import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';
import 'package:knittda/src/domain/model/user.dart';

class AdminLoginUseCase {
  final AuthenticationRepository _authenticationRepository;

  AdminLoginUseCase(this._authenticationRepository);

  Future<Result<void>> call() async {
    final Result<User> result = await _authenticationRepository.getAuthAdmin();

    if (result is Error<User>) {
      return Result.error(result.e);
    }

    return Result.success(null);
  }
}