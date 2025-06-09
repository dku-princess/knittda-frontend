import 'dart:convert';
import 'package:knittda/src/data/models/report_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportLocalDataSource {
  static const _reportKey = 'cached_report_json';
  static const _weekIdKey = 'cached_report_week_id';

  ///주차와 리포트 JSON을 SharedPreferences에 기록
  Future<void> save(String weekId, ReportModel report) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_weekIdKey, weekId);
    await prefs.setString(_reportKey, jsonEncode(report.toJson()));
  }

  ///weekId가 다르면 null, 같으면 반환
  Future<ReportModel?> load(String weekId) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedWeek = prefs.getString(_weekIdKey);
    if (cachedWeek != weekId) return null;
    final jsonStr = prefs.getString(_reportKey);
    if (jsonStr == null) return null;
    return ReportModel.fromJson(jsonDecode(jsonStr));
  }

  ///캐시 비우기
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_reportKey);
    await prefs.remove(_weekIdKey);
  }
}