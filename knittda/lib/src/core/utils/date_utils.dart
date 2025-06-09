class DateUtilsHelper {
  //padLeft: 지정한 길이보다 짧으면, 왼쪽에 문자를 채운다
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
    //현재 날짜와 시간을 가져온다
    final now = DateTime.now();

    // 이번 주 월요일 날짜 계산
    final monday = now.subtract( //현재 날짜에서 duration 만큼 뺀다
      Duration(days: now.weekday - DateTime.monday), //두 시간 사이의 간격을 나타냄
    );

    //문자열 생성
    return toHyphenFormat(monday);
  }
}