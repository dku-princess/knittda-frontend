import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _jwtKey = 'jwt';
  static const _uidKey = 'uid';
  final _storage = const FlutterSecureStorage();

  Future<void> save(String jwt) =>
      _storage.write(key: _jwtKey, value: jwt);

  Future<String?> read() =>
      _storage.read(key: _jwtKey);

  Future<void> delete() =>
      _storage.delete(key: _jwtKey);

  Future<void> saveUserId(String uid) =>
      _storage.write(key: _uidKey, value: uid);

  Future<String?> readUserId() =>
      _storage.read(key: _uidKey);

  Future<void> deleteUserId() =>
      _storage.delete(key: _uidKey);
}
