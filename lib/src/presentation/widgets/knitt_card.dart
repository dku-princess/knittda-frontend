import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// Knittda 공통 카드 컨테이너.
///
/// 표면·테두리·모서리·그림자·패딩을 디자인 토큰으로 구성한다.
/// Figma `Card` 컴포넌트와 대응한다.
class KnittCard extends StatelessWidget {
  const KnittCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.space16),
    this.onTap,
    this.elevated = false,
  });

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  /// true면 카드 그림자([AppElevation.card])를 준다.
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: elevated ? AppElevation.card : AppElevation.none,
      shadowColor: AppColors.black,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.border),
          ),
          child: child,
        ),
      ),
    );
  }
}
