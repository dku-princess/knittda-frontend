import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';

class SettingProfileImageUseCase {
  final AuthenticationRepository _repository;

  SettingProfileImageUseCase(this._repository);

  Future<Result<User>> call(XFile file) async {
    final result = await _repository.postProfileImage(file);

    return switch (result) {
      Success(:final data) => Result.success(data),
      Error(:final e) => Result.error(e),
    };
  }
}
