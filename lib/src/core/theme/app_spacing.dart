/// Knittda 간격/여백 토큰.
///
/// `EdgeInsets`·`SizedBox` 등에 반복 등장하던 간격 값을 스케일로 통합한다.
/// 스케일에 없는 예외 값(3, 13, 14, 50, 80, 120 등)은 의도적으로 유지한다.
class AppSpacing {
  AppSpacing._();

  // 4배수 그리드로 정규화한 스케일. 비표준 값(6·10·30 등)은 제거했다.
  static const double space0 = 0;
  static const double space4 = 4; // xs
  static const double space8 = 8; // sm
  static const double space12 = 12; // md
  static const double space16 = 16; // base
  static const double space20 = 20; // lg
  static const double space24 = 24; // xl
  static const double space32 = 32; // xxl
  static const double space40 = 40; // xxxl

  // 의미 별칭
  static const double xs = space4;
  static const double sm = space8;
  static const double md = space12;
  static const double base = space16;
  static const double lg = space20;
  static const double xl = space24;
  static const double xxl = space32;
  static const double xxxl = space40;
}

/// Knittda 모서리 반경 토큰 — 사용 종류(역할)별로 시스템화.
///
/// 값(숫자)이 아니라 "어디에 쓰는가"로 고른다.
class AppRadius {
  AppRadius._();

  /// 각 없음(직각).
  static const double none = 0;

  /// 태그·칩·작은 배지.
  static const double chip = 4;

  /// 버튼·입력·컨트롤.
  static const double button = 8;

  /// 카드·컨테이너·시트·이미지.
  static const double card = 10;

  /// pill·완전 둥근 요소.
  static const double pill = 20;
}
