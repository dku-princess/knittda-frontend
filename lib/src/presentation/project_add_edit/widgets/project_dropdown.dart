import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_form_text_styles.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_input.dart';

/// 작품 입력 화면의 드롭다운.
///
/// 입력칸을 탭하면 바로 아래로 선택 목록이 펼쳐지고, 입력칸 밑줄을 덮는다.
/// 아래 공간이 부족하면 입력칸 바로 위로 펼쳐진다.
/// 목록 폭은 입력칸 폭과 같고, 선택된 항목은 배경색으로만 표시한다.
///
/// 에러 문구가 필요하면 [error]에 빈 문자열(밑줄만)을 넘기고, 문구는 바깥에서 그린다.
/// 문구를 안에서 그리면 목록이 문구 아래에서 열린다.
///
/// | 옵션 | 설명 |
/// |---|---|
/// | [options] | 선택 항목 목록. |
/// | [value] | 선택된 항목. null이면 플레이스홀더. |
/// | [labelOf] | 항목을 화면에 보여줄 문구로 바꾼다. |
/// | [onChanged] | 항목을 고를 때 호출. |
/// | [placeholder] | 플레이스홀더. |
/// | [loading] | true면 목록을 열지 않고 불러오는 중 문구를 보여준다. |
/// | [error] | 에러 문구. |
class ProjectDropdown<T> extends StatelessWidget {
  const ProjectDropdown({
    super.key,
    required this.options,
    required this.value,
    required this.labelOf,
    required this.onChanged,
    this.placeholder,
    this.loading = false,
    this.error,
  });

  final List<T> options;
  final T? value;
  final String Function(T option) labelOf;
  final ValueChanged<T> onChanged;
  final String? placeholder;
  final bool loading;
  final String? error;

  static const double _itemHeight = 48;
  // AppRadius에 2가 없어 로컬 값으로 둔다.
  static const double _menuRadius = 2;
  static const Color _itemTextColor = AppColors.textSecondary;
  static const Color _selectedItemColor = AppColors.primaryLight;

  static const double _itemPaddingH = AppSpacing.space16;

  // TODO(design): 불러오는 중 문구
  static const String _loadingText = '불러오는 중';

  @override
  Widget build(BuildContext context) {
    final value = this.value;

    // 목록 폭을 입력칸 폭과 맞추기 위해 부모 폭을 읽는다.
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return MenuAnchor(
          // 목록 위 테두리를 입력칸 밑줄과 1px 겹쳐 밑줄을 덮는다.
          alignmentOffset: const Offset(0, -1),
          style: MenuStyle(
            backgroundColor: const WidgetStatePropertyAll(AppColors.white),
            surfaceTintColor: const WidgetStatePropertyAll(
              AppColors.transparent,
            ),
            elevation: const WidgetStatePropertyAll(AppElevation.none),
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
            fixedSize: WidgetStatePropertyAll(Size.fromWidth(width)),
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(_menuRadius)),
                side: BorderSide(color: AppColors.border),
              ),
            ),
          ),
          menuChildren: [
            for (final option in options) _buildItem(option, width),
          ],
          builder: (context, controller, child) {
            return ProjectInput.dropdown(
              value: loading || value == null ? null : labelOf(value),
              placeholder: loading ? _loadingText : placeholder,
              error: error,
              onTap: () {
                if (loading || options.isEmpty) return;
                controller.isOpen ? controller.close() : controller.open();
              },
            );
          },
        );
      },
    );
  }

  Widget _buildItem(T option, double width) {
    return MenuItemButton(
      onPressed: () => onChanged(option),
      style: ButtonStyle(
        fixedSize: WidgetStatePropertyAll(Size(width, _itemHeight)),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: _itemPaddingH),
        ),
        alignment: Alignment.centerLeft,
        backgroundColor: WidgetStatePropertyAll(
          option == value ? _selectedItemColor : AppColors.white,
        ),
        shape: const WidgetStatePropertyAll(RoundedRectangleBorder()),
      ),
      child: Text(
        labelOf(option),
        style: ProjectFormTextStyles.body.copyWith(color: _itemTextColor),
      ),
    );
  }
}
