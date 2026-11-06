import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_form_text_styles.dart';

/// 바늘 굵기 단위.
enum NeedleSizeUnit {
  mm('mm'),
  ho('호');

  const NeedleSizeUnit(this.label);

  final String label;
}

/// 작품 입력 화면의 단위 토글.
///
/// 단위만 바꾸고, 굵기 숫자는 상위에서 그대로 유지한다.
///
/// | 옵션 | 설명 |
/// |---|---|
/// | [value] | 현재 선택된 단위. |
/// | [onChanged] | 단위 탭 콜백. |
class ProjectUnitToggle extends StatelessWidget {
  const ProjectUnitToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final NeedleSizeUnit value;
  final ValueChanged<NeedleSizeUnit> onChanged;

  static const double _tabWidth = 48;
  static const double _height = 24;

  // 시각 높이(24)와 별개로 확보하는 터치 높이(48).
  static const double _touchHeight = kMinInteractiveDimension;

  static const Color _selectedTextColor = AppColors.textSecondary;
  static const Color _unselectedTextColor = AppColors.grey600;

  static const Color _selectedUnderlineColor = AppColors.primary;
  static const double _selectedUnderlineWidth = 2;
  static const Color _unselectedUnderlineColor = AppColors.border;
  static const double _unselectedUnderlineWidth = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final unit in NeedleSizeUnit.values)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onChanged(unit),
            child: SizedBox(
              height: _touchHeight,
              child: Center(
                child: _buildTab(unit.label, selected: unit == value),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTab(String label, {required bool selected}) {
    return Container(
      width: _tabWidth,
      height: _height,
      alignment: Alignment.center,
      // 밑줄은 덧그린다(17px 글자 공간 유지).
      foregroundDecoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: selected
                ? _selectedUnderlineColor
                : _unselectedUnderlineColor,
            width: selected
                ? _selectedUnderlineWidth
                : _unselectedUnderlineWidth,
          ),
        ),
      ),
      child: Text(
        label,
        style: ProjectFormTextStyles.body.copyWith(
          color: selected ? _selectedTextColor : _unselectedTextColor,
        ),
      ),
    );
  }
}
