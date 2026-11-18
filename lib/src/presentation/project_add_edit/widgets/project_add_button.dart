import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_form_text_styles.dart';

/// 작품 입력 화면의 `+ 항목 추가` 버튼.
///
/// | 옵션 | 설명 |
/// |---|---|
/// | [label] | 버튼 문구('실 추가' 등). 앞의 `+ `는 위젯이 자동으로 붙인다. |
/// | [onPressed] | 탭 콜백. |
class ProjectAddButton extends StatelessWidget {
  const ProjectAddButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  static const double _height = 48;

  static const Color _textColor = AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: _height,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '+ $label',
            style: ProjectFormTextStyles.body.copyWith(color: _textColor),
          ),
        ),
      ),
    );
  }
}
