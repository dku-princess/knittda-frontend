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

  static String getCurrentWeekId() {
    final now = DateTime.now();

    // 이번 주 월요일 0시 계산 (weekday: 월=1 … 일=7)
    final monday = now.subtract(
      Duration(days: now.weekday - DateTime.monday),
    );

    //문자열 생성
    return toHyphenFormat(monday);
  }
}