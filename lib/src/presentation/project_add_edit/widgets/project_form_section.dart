import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_form_text_styles.dart';

/// 작품 입력 화면의 FormSection.
///
/// | 옵션 | 설명 |
/// |---|---|
/// | [title] | 섹션 제목. |
/// | [children] | 카드 안에 세로로 놓을 행들. |
class ProjectFormSection extends StatelessWidget {
  const ProjectFormSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  static const double _padding = AppSpacing.space20;
  static const double _titleGap = AppSpacing.space20;
  static const double _rowGap = AppSpacing.space16;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: ProjectFormTextStyles.label),
          const SizedBox(height: _titleGap),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: _rowGap,
            children: children,
          ),
        ],
      ),
    );
  }
}
