/// Knittda 아이콘 크기 토큰 — 역할별로 시스템화.
///
/// 값(숫자)이 아니라 "어디에 쓰는가"로 고른다. Material `Icon`의 기본값은
/// [base](24)이며, 실사용에 없는 예외값(14·36 등)은 해당 위젯에 로컬로 둔다.
class AppIconSize {
  AppIconSize._();

  /// 조밀한 인라인 아이콘·작은 배지.
  static const double sm = 16;

  /// 리스트·입력·보조 컨트롤 아이콘.
  static const double md = 20;

  /// 기본 액션 아이콘 (Material `Icon` 기본값).
  static const double base = 24;

  /// 강조 아이콘·툴바 주요 액션.
  static const double lg = 32;

  /// 피처·빈 상태·플레이스홀더 아이콘.
  static const double xl = 40;
}
