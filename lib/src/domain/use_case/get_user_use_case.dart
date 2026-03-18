import 'package:knittda/src/domain/repository/authentication_repository.dart';
import 'package:knittda/src/domain/model/user.dart';

class GetUserUseCase {
  final AuthenticationRepository _repository;

  const GetUserUseCase(this._repository);

  Stream<User> execute() {
    return _repository.userStream();
  }

}
