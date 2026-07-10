import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/app_colors.dart';

/// 글자 크기 스케일 (관측값 10~24 기준).
class AppFontSize {
  AppFontSize._();

  static const double xs = 10;
  static const double sm = 12;
  static const double md = 14; // 본문 기본
  static const double lg = 16;
  static const double xl = 20;
  static const double display = 24;
}

/// 글자 굵기 스케일.
class AppFontWeight {
  AppFontWeight._();

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

/// 의미 기반 텍스트 스타일 프리셋 (Pretendard).
///
/// 새 화면은 이 프리셋을 우선 사용한다. 색상은 [AppColors.textPrimary]가
/// 기본이며 `.copyWith(color: ...)`로 재정의한다.
class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Pretendard';

  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSize.display,
    fontWeight: AppFontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSize.xl,
    fontWeight: AppFontWeight.semibold,
    color: AppColors.textPrimary,
  );

  static const TextStyle heading = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSize.lg,
    fontWeight: AppFontWeight.semibold,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSize.md,
    fontWeight: AppFontWeight.regular,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyStrong = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSize.md,
    fontWeight: AppFontWeight.semibold,
    color: AppColors.textPrimary,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSize.sm,
    fontWeight: AppFontWeight.regular,
    color: AppColors.textHint,
  );
}
