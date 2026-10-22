import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// Knittda 뜨개 태그(선택 상태를 갖는 라벨). Figma `Tag` 컴포넌트와 대응.
///
/// 아웃라인 2상태 고정. `caption` 크기, radius [AppRadius.tag](6).
/// 인터랙션(토글)은 상위에서 [GestureDetector] 등으로 감싼다.
/// 카테고리 등 표시 전용 라벨은 [KnittdaChip]을 쓴다.
///
/// | 옵션 | 설명 |
/// |---|---|
/// | [label] | 태그 문구(필수). |
/// | [selected] | 선택 상태. true=primary, false=grey400. 기본 true. |
///
/// - **selected**: 투명 배경 + `primary` 테두리 + `primary` 글씨.
/// - **disabled(미선택)**: 투명 배경 + `grey400` 테두리 + `grey400` 글씨.
class KnittdaTag extends StatelessWidget {
  const KnittdaTag({
    super.key,
    required this.label,
    this.selected = true,
  });

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final Color color = selected ? AppColors.primary : AppColors.grey400;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: AppSpacing.space4,
      ),
      decoration: BoxDecoration(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.tag),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(color: color),
      ),
    );
  }
}
