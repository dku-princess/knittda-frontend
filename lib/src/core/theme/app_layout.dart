import 'app_spacing.dart';

/// Knittda 레이아웃 토큰 — 화면 레벨 여백/인셋 "패턴"을 의미 단위로 정의한다.
///
/// 원자 간격 토큰(`AppSpacing`)이 "얼마나"를 담당한다면, `AppLayout`은
/// "어디에 쓰는가"(화면 가장자리·스크롤 하단 여유 등)를 담당한다.
/// 값(숫자)이 아니라 목적으로 고른다.
class AppLayout {
  AppLayout._();

  /// 화면 좌우 가장자리 표준 여백.
  ///
  /// 기존 16/20/24 혼재를 20으로 통일한다. 스크린 최상위(가장자리) 패딩에만 쓰고,
  /// 컴포넌트 내부 여백(`widgets/knittda_*`)에는 쓰지 않는다.
  static const double screenPaddingH = AppSpacing.space20;

  /// 스크롤 콘텐츠 하단 여유 인셋 — 마지막 항목이 화면 끝에 붙지 않게 한다.
  ///
  /// 편집 폼·아티클 스크롤 등 일반 스크롤 화면에 쓴다. (기존 50 → 48로 4배수 정규화)
  static const double contentBottomInset = 48;

  /// FAB가 리스트 마지막 항목을 가리지 않도록 하는 스크롤 하단 인셋. (projects)
  static const double fabBottomInset = 80;

  /// 하단 고정 액션 버튼(로그인 등) 위쪽 여유 인셋.
  static const double actionBottomInset = 120;
}
