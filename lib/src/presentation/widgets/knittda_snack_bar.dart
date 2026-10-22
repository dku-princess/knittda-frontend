import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// 스낵바 톤 — 배경색을 결정한다.
enum KnittdaSnackTone { info, success, error }

/// Knittda 공통 스낵바 헬퍼.
///
/// 앱 전반에 흩어진 `ScaffoldMessenger.of(context).showSnackBar(SnackBar(...))`
/// 반복을 하나로 통합한다. 배경(톤별)·타이포·radius를 디자인 토큰으로 고정한다.
///
/// ```dart
/// KnittdaSnackBar.show(context, '저장했어요', tone: KnittdaSnackTone.success);
/// ```
class KnittdaSnackBar {
  KnittdaSnackBar._();

  static void show(
    BuildContext context,
    String message, {
    KnittdaSnackTone tone = KnittdaSnackTone.info,
  }) {
    final Color background = switch (tone) {
      KnittdaSnackTone.success => AppColors.primary,
      KnittdaSnackTone.error => AppColors.error,
      KnittdaSnackTone.info => AppColors.grey800,
    };

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppTextStyles.caption.copyWith(color: AppColors.white),
          ),
          backgroundColor: background,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
        ),
      );
  }
}
