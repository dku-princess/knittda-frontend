import 'dart:math';

import 'package:knittda/src/data/data_sources/secure_storage.dart';

class DeviceIdStorage {
  final SecureStorage _storage;

  DeviceIdStorage(this._storage);

  static const _key = 'device_id';

  Future<String> getOrCreate() async {
    final existing = await _storage.read(_key);
    if (existing != null && existing.isNotEmpty) return existing;
    final newId = _generateUuidV4();
    try {
      await _storage.write(_key, newId);
    } catch (_) {
      // 저장 실패해도 앱 부팅을 막지 않음
    }
    return newId;
  }

  String _generateUuidV4() {
    final rand = Random.secure();
    final bytes = List<int>.generate(16, (_) => rand.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    String hex(int b) => b.toRadixString(16).padLeft(2, '0');
    final h = bytes.map(hex).join();
    return '${h.substring(0, 8)}-${h.substring(8, 12)}-${h.substring(12, 16)}-${h.substring(16, 20)}-${h.substring(20)}';
  }
}
