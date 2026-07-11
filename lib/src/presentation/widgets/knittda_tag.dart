import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// 태그 스타일. Figma `Tag` 컴포넌트의 Style 변형과 1:1.
enum KnittdaTagStyle {
  /// 투명 배경 + primary 테두리 + primary 글씨.
  outline,

  /// primary 채움 + 흰 글씨.
  filled,

  /// 회색 표면 + 보조 텍스트(중립 태그).
  grey,
}

/// Knittda 공통 태그(메타데이터 라벨). Figma `Tag` 컴포넌트와 대응.
///
/// `caption` 크기 고정. 스타일 3종과 모서리 반경을 선택한다.
///
/// | 옵션 | 설명 |
/// |---|---|
/// | [label] | 태그 문구(필수). |
/// | [style] | outline(테두리)·filled(채움)·grey(회색) 중 선택. 기본 outline. |
/// | [radius] | 모서리 반경. 뜨개 태그는 6, 카테고리 태그는 [AppRadius.chip](4). |
class KnittdaTag extends StatelessWidget {
  const KnittdaTag({
    super.key,
    required this.label,
    this.style = KnittdaTagStyle.outline,
    this.radius = AppRadius.chip,
  });

  final String label;
  final KnittdaTagStyle style;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final _TagPalette p = _paletteFor(style);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: AppSpacing.space4,
      ),
      decoration: BoxDecoration(
        color: p.background,
        borderRadius: BorderRadius.circular(radius),
        border: p.border == null ? null : Border.all(color: p.border!),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(color: p.foreground),
      ),
    );
  }

  static _TagPalette _paletteFor(KnittdaTagStyle style) {
    switch (style) {
      case KnittdaTagStyle.outline:
        return const _TagPalette(
          background: AppColors.transparent,
          foreground: AppColors.primary,
          border: AppColors.primary,
        );
      case KnittdaTagStyle.filled:
        return const _TagPalette(
          background: AppColors.primary,
          foreground: AppColors.white,
        );
      case KnittdaTagStyle.grey:
        return const _TagPalette(
          background: AppColors.surfaceAlt,
          foreground: AppColors.textSecondary,
        );
    }
  }
}

class _TagPalette {
  const _TagPalette({
    required this.background,
    required this.foreground,
    this.border,
  });

  final Color background;
  final Color foreground;
  final Color? border;
}
