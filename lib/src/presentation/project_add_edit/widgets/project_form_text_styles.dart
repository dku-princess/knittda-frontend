import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

// TODO(design): 17px 확정 시 AppTextStyles 프리셋으로 승격
/// 작품 입력 화면 공통 글자 스타일.
///
/// 17px은 [AppTextStyles] 프리셋에 없어 이 화면에서만 따로 정의한다.
class ProjectFormTextStyles {
  ProjectFormTextStyles._();

  static const double _fontSize = 17;

  /// 17px, 색은 `copyWith(color:)`로 지정.
  static const TextStyle body = TextStyle(
    fontFamily: AppTextStyles.fontFamily,
    fontSize: _fontSize,
    fontWeight: AppFontWeight.regular,
    height: AppTextStyles.lineHeight,
    color: AppColors.textPrimary,
  );

  /// 17px semibold. 입력 줄 제목(작품명, 시작일 등)에 사용.
  static const TextStyle label = TextStyle(
    fontFamily: AppTextStyles.fontFamily,
    fontSize: _fontSize,
    fontWeight: AppFontWeight.semibold,
    height: AppTextStyles.lineHeight,
    color: AppColors.textSecondary,
  );
}
