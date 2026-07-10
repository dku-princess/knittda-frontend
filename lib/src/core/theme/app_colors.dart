import 'package:flutter/material.dart';

/// Knittda 색상 토큰.
///
/// 앱 전반에 흩어져 있던 하드코딩 색상을 의미 기반 이름으로 통합한 단일 소스.
/// 실사용 기준으로 정리: 중립 6단계, 브랜드 2종, 텍스트 3단계, error 1종.
/// (단일 화면 전용 색은 해당 위젯에 로컬 상수로 둔다.)
class AppColors {
  AppColors._();

  // ── Brand ────────────────────────────────────────────────
  /// 메인 브랜드 그린. 강조·주요 버튼·활성 상태.
  static const Color primary = Color(0xFF0ABE8C);

  /// 브랜드 그린의 밝은 변형. 보조 강조·배지.
  static const Color primaryLight = Color(0xFF7ECDC0);

  // ── Neutrals (밝음 → 어두움, 6단계) ──────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey50 = Color(0xFFF5F7F8); // 배경 틴트
  static const Color grey100 = Color(0xFFEEEEEE); // muted 표면
  static const Color grey200 = Color(0xFFE0E0E0); // 테두리
  static const Color grey400 = Color(0xFF9E9E9E); // 힌트·비활성 텍스트
  static const Color grey600 = Color(0xFF757575); // 보조 텍스트
  static const Color grey800 = Color(0xFF4D4D4D); // 강한 텍스트
  static const Color black = Color(0xFF000000);

  // ── Surface ──────────────────────────────────────────────
  /// muted 보조 표면. (기본 배경은 [grey50], 표면은 [white]을 직접 사용)
  static const Color surfaceAlt = grey100;

  // ── Feedback (상태) ──────────────────────────────────────
  static const Color error = Color(0xFFF44336);

  static const Color transparent = Color(0x00000000);

  // ── Text (의미 별칭, 3단계) ──────────────────────────────
  static const Color textPrimary = black;
  static const Color textSecondary = grey800;
  static const Color textHint = grey400; // 보조 이하·힌트·비활성 공용

  // ── Border ───────────────────────────────────────────────
  static const Color border = grey200;
}
