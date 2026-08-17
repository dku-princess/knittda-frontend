import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// 칩 스타일. Figma `Chip` 컴포넌트의 Style 변형과 1:1.
enum KnittdaChipStyle {
  /// 투명 배경 + primary 테두리 + primary 글씨.
  outline,

  /// primary 채움 + 흰 글씨.
  filled,

  /// 회색 표면 + 보조 텍스트(중립 칩).
  grey,
}

/// Knittda 공통 칩(카테고리 라벨). Figma `Chip` 컴포넌트와 대응.
///
/// 표시 전용(인터랙션 없음). `caption` 크기 고정, radius [AppRadius.chip](4).
/// 선택 상태를 갖는 뜨개 태그는 [KnittdaTag]를 쓴다.
///
/// | 옵션 | 설명 |
/// |---|---|
/// | [label] | 칩 문구(필수). |
/// | [style] | outline(테두리)·filled(채움)·grey(회색) 중 선택. 기본 outline. |
class KnittdaChip extends StatelessWidget {
  const KnittdaChip({
    super.key,
    required this.label,
    this.style = KnittdaChipStyle.outline,
  });

  final String label;
  final KnittdaChipStyle style;

  @override
  Widget build(BuildContext context) {
    final _ChipPalette p = _paletteFor(style);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: AppSpacing.space4,
      ),
      decoration: BoxDecoration(
        color: p.background,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: p.border == null ? null : Border.all(color: p.border!),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(color: p.foreground),
      ),
    );
  }

  static _ChipPalette _paletteFor(KnittdaChipStyle style) {
    switch (style) {
      case KnittdaChipStyle.outline:
        return const _ChipPalette(
          background: AppColors.transparent,
          foreground: AppColors.primary,
          border: AppColors.primary,
        );
      case KnittdaChipStyle.filled:
        return const _ChipPalette(
          background: AppColors.primary,
          foreground: AppColors.white,
        );
      case KnittdaChipStyle.grey:
        return const _ChipPalette(
          background: AppColors.surfaceAlt,
          foreground: AppColors.textSecondary,
        );
    }
  }
}

class _ChipPalette {
  const _ChipPalette({
    required this.background,
    required this.foreground,
    this.border,
  });

  final Color background;
  final Color foreground;
  final Color? border;
}
