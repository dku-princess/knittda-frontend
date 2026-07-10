import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// 배지 톤. Figma `Badge` 컴포넌트의 Tone 변형과 1:1.
enum KnittBadgeTone { primary, neutral }

/// Knittda 공통 배지(작은 라벨/칩).
class KnittBadge extends StatelessWidget {
  const KnittBadge({
    super.key,
    required this.label,
    this.tone = KnittBadgeTone.primary,
  });

  final String label;
  final KnittBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final bool primary = tone == KnittBadgeTone.primary;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: AppSpacing.space4,
      ),
      decoration: BoxDecoration(
        color: primary ? AppColors.primary : AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: primary ? AppColors.white : AppColors.textSecondary,
        ),
      ),
    );
  }
}
