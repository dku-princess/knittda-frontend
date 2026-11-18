import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_form_text_styles.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_input.dart';

/// 작품 입력 화면 Field 제목 + 입력
///
/// 제목은 고정 폭으로 왼쪽에 두고, 입력칸은 남은 폭을 채운다.
/// 에러는 입력칸이 직접 표시.
///
/// | 옵션 | 설명 |
/// |---|---|
/// | [label] | 제목. |
/// | [child] | 입력칸(ProjectInput, ProjectDropdown). |
class ProjectField extends StatelessWidget {
  const ProjectField({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  static const double _labelWidth = 48;
  static const double _labelGap = AppSpacing.space12;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: _labelWidth,
          height: ProjectInput.height,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              maxLines: 1,
              softWrap: false,
              style: ProjectFormTextStyles.label,
            ),
          ),
        ),
        const SizedBox(width: _labelGap),
        Expanded(child: child),
      ],
    );
  }
}
