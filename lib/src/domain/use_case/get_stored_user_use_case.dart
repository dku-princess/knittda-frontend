import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';

class GetStoredUserUseCase {
  final AuthenticationRepository _authenticationRepository;

  GetStoredUserUseCase(this._authenticationRepository);

  Future<Result<User?>> call() async {
    final user = await _authenticationRepository.getStoredUser();

    if(user != null) {
      return Result.success(user);
    } else {
      return Result.error('getStoredUser_fail');
    }
  }
}