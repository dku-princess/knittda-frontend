import 'package:intl/intl.dart';

class DateUtilsHelper {
  static String toHyphenFormat(DateTime date) =>
      "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

  static String toDotFormat(DateTime date) =>
      "${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}";

  static DateTime fromDotFormat(String date) {
    final parts = date.split('.');
    return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
  }

  static String toHourMinuteFormat(DateTime date) =>
      "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";

  /// 현재 날짜가 속한 “연도-주차(ISO)” 문자열을 반환한다. 예: `2025-23`
  static String getCurrentWeekId() {
    final now = DateTime.now();

    // 이번 주 월요일 날짜를 얻는다 (ISO 기준: 월요일=1 … 일요일=7)
    final monday = now.subtract(
      Duration(days: now.weekday - DateTime.monday),
    );

    // ISO-8601 주차(1~53) 추출
    final weekNumber = int.parse(DateFormat('w').format(monday));

    return '${monday.year}-$weekNumber';
  }
}