import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _jwtKey = 'jwt';
  static const _uidKey = 'uid';
  final _storage = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  Future<void> save(String jwt) =>
      _storage.write(key: _jwtKey, value: jwt);

  Future<String?> read() async {
    try{
      return await _storage.read(key: _jwtKey);
    } on PlatformException catch (_) {
      debugPrint('storage read error');
      try{
        await _storage.deleteAll();
      } catch (_) {
        debugPrint('storage deleteAll error');
      }
      return null;
    }
  }

  Future<void> delete() =>
      _storage.delete(key: _jwtKey);

  Future<void> saveUserId(String uid) =>
      _storage.write(key: _uidKey, value: uid);

  Future<String?> readUserId() async {
    try{
      return await _storage.read(key: _uidKey);
    } on PlatformException catch (_) {
      debugPrint('storage read error');
      try{
        await _storage.deleteAll();
      } catch (_) {
        debugPrint('storage deleteAll error');
      }
      return null;
    }
  }

  Future<void> deleteUserId() =>
      _storage.delete(key: _uidKey);
}
