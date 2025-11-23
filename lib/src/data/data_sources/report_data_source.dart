import 'dart:convert';

import 'package:knittda/src/domain/model/report.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportDataSource {
  static const _reportJsonKey = 'cached_report_json';
  static const _reportWeekIdKey = 'cached_report_week_id';

  final SharedPreferencesAsync prefs;

  ReportDataSource(this.prefs);

  Future<void> saveData(String weekId, Report report) async {
    await prefs.setString(_reportWeekIdKey, weekId);
    await prefs.setString(_reportJsonKey, jsonEncode(report.toJson()));
  }

  Future<Report?> readData(String weekId) async {
    final cachedWeekId = await prefs.getString(_reportWeekIdKey);
    if (cachedWeekId != weekId) return null;

    final reportJson = await prefs.getString(_reportJsonKey);
    if (reportJson == null) return null;

    return Report.fromJson(jsonDecode(reportJson));
  }

  /// 캐시 삭제
  Future<void> clearData() async {
    await prefs.remove(_reportJsonKey);
    await prefs.remove(_reportWeekIdKey);
  }
}
