import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BannerLocalStorage {
  static const _registryKey = 'banner_dismissed_keys';

  final SharedPreferencesAsync _prefs;

  BannerLocalStorage(this._prefs);

  /// 해당 배너가 오늘 dismiss 되었는지 확인
  Future<bool> isDismissedForToday(int bannerId) async {
    final key = _makeKey(bannerId);
    return await _prefs.getBool(key) ?? false;
  }

  /// 해당 배너를 오늘 하루 동안 미노출로 저장
  Future<void> dismissForToday(int bannerId) async {
    final key = _makeKey(bannerId);
    await _prefs.setBool(key, true);
    await _addToRegistry(key);
  }

  /// 오래된 키 정리
  Future<void> cleanUpOldKeys() async {
    try {
      final keys = await _getRegistry();
      if (keys.isEmpty) return;

      final today = DateUtilsHelper.toHyphenFormat(DateTime.now());
      final keysToKeep = <String>[];

      for (final key in keys) {
        if (key.endsWith(today)) {
          keysToKeep.add(key);
        } else {
          await _prefs.remove(key);
        }
      }

      await _saveRegistry(keysToKeep);
    } catch (e) {
      debugPrint('BannerLocalStorage: cleanUpOldKeys error');
    }
  }

  String _makeKey(int bannerId) {
    final today = DateUtilsHelper.toHyphenFormat(DateTime.now());
    return 'banner_dismissed_${bannerId}_$today';
  }

  /// 등록된 키 목록 조회
  Future<List<String>> _getRegistry() async {
    final json = await _prefs.getString(_registryKey);
    if (json == null) return [];
    return List<String>.from(jsonDecode(json));
  }

  /// 등록된 키 목록 저장
  Future<void> _saveRegistry(List<String> keys) async {
    await _prefs.setString(_registryKey, jsonEncode(keys));
  }

  /// 새 키를 등록 목록에 추가 (중복 방지)
  Future<void> _addToRegistry(String key) async {
    final keys = await _getRegistry();
    if (!keys.contains(key)) {
      keys.add(key);
      await _saveRegistry(keys);
    }
  }
}
