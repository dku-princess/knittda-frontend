import 'package:knittda/src/data/data_sources/authentication_api.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/data/data_sources/social_login.dart';
import 'package:knittda/src/data/data_sources/social_login_result.dart';
import 'package:knittda/src/data/data_sources/user_storage.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';
import 'package:knittda/src/domain/util/social_login_type.dart';

import '../data_sources/token_storage.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationApi _api;
  final SocialLogin _kakao;
  final SocialLogin _apple;
  final TokenStorage _tokenStorage;
  final UserStorage _userStorage;

  AuthenticationRepositoryImpl(
    this._api,
    this._kakao,
    this._apple,
    this._tokenStorage,
    this._userStorage,
  );

  @override
  Future<Result<User>> getAuthMe() async {
    final Result<Map<String, dynamic>> result = await _api.getAuthMe();

    return switch (result) {
      Success(:final data) => _saveAuth(data),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<Result<User>> getAuthKakao({required String token}) async {
    final Result<Map<String, dynamic>> result = await _api.getAuthKakao(
      token: token,
    );

    return switch (result) {
      Success(:final data) => _saveAuth(data),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<Result<User>> getAuthApple({
    required String token,
    required String name,
  }) async {
    final Result<Map<String, dynamic>> result = await _api.getAuthApple(
      token: token,
      name: name,
    );

    return switch (result) {
      Success(:final data) => _saveAuth(data),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<Result<User>> getAuthAdmin() async {
    final Result<Map<String, dynamic>> result = await _api.getAuthAdmin();

    return switch (result) {
      Success(:final data) => _saveAuth(data),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<Result<void>> deleteAuthSignout() async {
    final Result<void> result = await _api.deleteAuthSignout();

    return switch (result) {
      Success() => Result.success(null),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<Result<SocialLoginResult>> socialLogin({
    required SocialLoginType type,
  }) async {
    final result = switch (type) {
      Kakao() => await _kakao.login(),
      Apple() => await _apple.login(),
    };

    if (result != null) {
      return Result.success(result);
    } else {
      return Result.error('socialLogin_fail');
    }
  }

  @override
  Future<Result<bool>> socialLogout({required SocialLoginType type}) async {
    final bool result;

    switch (type) {
      case Kakao():
        result = await _kakao.logout();
      case Apple():
        result = await _apple.logout();
    }

    if (result) {
      return Result.success(result);
    } else {
      return Result.error('socialLogout_fail');
    }
  }

  @override
  Future<Result<bool>> socialUnlink({required SocialLoginType type}) async {
    final bool result;

    switch (type) {
      case Kakao():
        result = await _kakao.unlink();
      case Apple():
        result = await _apple.unlink();
    }

    if (result) {
      return Result.success(result);
    } else {
      return Result.error('socialUnlink_fail');
    }
  }

  Future<Result<User>> _saveAuth(Map<String, dynamic> data) async {
    final token = data['jwt'];

    if (token == null) {
      final user = User.fromJson(data);
      await _userStorage.saveUser(user);
      return Result.success(user);
    } else {
      final user = User.fromJson(data['user']);
      await _userStorage.saveUser(user);
      await _tokenStorage.saveToken(token);
      return Result.success(user);
    }
  }

  @override
  Future<String?> getStoredToken() async {
    return _tokenStorage.readToken();
  }

  @override
  Future<User?> getStoredUser() async {
    return _userStorage.readUser();
  }

  @override
  Future<void> clearLocalAuth() async {
    await _tokenStorage.deleteToken();
    await _userStorage.deleteUser();
  }
}
