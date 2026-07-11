import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// Knittda 공통 태그(메타데이터 라벨). Figma `Tag` 컴포넌트와 대응.
///
/// **Outline** 스타일: 투명 배경 + `primary` 테두리 + `primary` 글씨,
/// `AppRadius.chip`(4) 모서리, `caption` 크기. 니트 태그·카테고리 등에 공통 사용.
///
/// | 옵션 | 설명 |
/// |---|---|
/// | [label] | 태그 문구(필수). |
class KnittdaTag extends StatelessWidget {
  const KnittdaTag({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space8,
        vertical: AppSpacing.space4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: AppColors.primary),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(color: AppColors.primary),
      ),
    );
  }
}
