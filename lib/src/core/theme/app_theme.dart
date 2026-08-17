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
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.surfaceAlt,
          primary: AppColors.primary,
        ),
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
