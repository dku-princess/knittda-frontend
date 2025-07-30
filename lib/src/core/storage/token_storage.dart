import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _jwtKey = 'jwt';
  final _storage = const FlutterSecureStorage();

  Future<void> save(String jwt) =>
      _storage.write(key: _jwtKey, value: jwt);

  Future<String?> read() =>
      _storage.read(key: _jwtKey);

  Future<void> delete() =>
      _storage.delete(key: _jwtKey);
}
