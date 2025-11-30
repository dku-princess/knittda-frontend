import 'dart:convert';

import 'package:knittda/src/data/data_sources/secure_storage.dart';
import 'package:knittda/src/domain/model/user.dart';

class UserStorage {
  final SecureStorage _storage;

  UserStorage(this._storage);

  static const _userKey = 'user';

  Future<void> saveUser(User user) async {
    final jsonString = jsonEncode(user.toJson());
    await _storage.write(_userKey, jsonString);
  }

  Future<User?> readUser() async {
    final jsonString = await _storage.read(_userKey);
    if (jsonString == null) return null;

    try {
      final map = jsonDecode(jsonString) as Map<String, dynamic>;
      return User.fromJson(map);
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteUser() async {
    await _storage.delete(_userKey);
  }

}