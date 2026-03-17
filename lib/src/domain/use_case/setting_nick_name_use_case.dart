import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';

class SettingNickNameUseCase {
  final AuthenticationRepository _repository;

  SettingNickNameUseCase(this._repository);

  Future<Result<User>> call(User user) async {
    final result = await _repository.putNickName(user);

    return switch (result) {
      Success(:final data) => Result.success(data),
      Error(:final e) => Result.error(e),
    };
  }
}