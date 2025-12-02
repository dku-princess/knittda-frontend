import 'package:knittda/src/data/data_sources/secure_storage.dart';

class TokenStorage {
  final SecureStorage _storage;

  TokenStorage(this._storage);

  static const _tokenKey = 'jwt';

  Future<void> saveToken(String token) async {
    await _storage.write(_tokenKey, token);
  }

  Future<String?> readToken() async {
    return await _storage.read(_tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(_tokenKey);
  }
}
