import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';

class SettingNicknameUseCase {
  final AuthenticationRepository _repository;

  SettingNicknameUseCase(this._repository);

  Future<Result<User>> call(User user) async {
    final result = await _repository.putNickname(user);

    return switch (result) {
      Success(:final data) => Result.success(data),
      Error(:final e) => Result.error(e),
    };
  }
}