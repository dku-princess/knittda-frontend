import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/app_colors.dart';
import 'package:knittda/src/core/theme/app_elevation.dart';
import 'package:knittda/src/core/theme/app_typography.dart';

/// 토큰으로부터 조립한 전역 [ThemeData].
class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        fontFamily: AppTextStyles.fontFamily,
        splashColor: AppColors.transparent, // 클릭 시 퍼지는 효과 제거
        scaffoldBackgroundColor: AppColors.white,
        // primary만 override하면 onPrimary/primaryContainer/surfaceTint는
        // 여전히 seedColor(surfaceAlt) 기준으로 계산되어 색조가 어긋난다.
        // seedColor 자체를 브랜드 그린으로 지정해 파생 색상을 일관되게 생성.
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          elevation: AppElevation.none,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.white,
        ),
        textTheme: _textTheme,
      );

  static const TextTheme _textTheme = TextTheme(
    displaySmall: AppTextStyles.display,
    titleLarge: AppTextStyles.title,
    titleMedium: AppTextStyles.heading,
    bodyLarge: AppTextStyles.bodyStrong,
    bodyMedium: AppTextStyles.body,
    bodySmall: AppTextStyles.caption,
  );
}
