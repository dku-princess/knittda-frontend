import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';
import 'package:knittda/src/core/utils/max_length_exceeded_formatter.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_form_text_styles.dart';

/// Input 종류.
enum ProjectInputType { text, date, dropdown }

/// 오른쪽 아이콘 정보(아이콘, 크기, 폭).
typedef _TrailingIcon = ({IconData icon, double size, double slotWidth});

/// 작품 입력 화면의 밑줄형 입력 필드.
///
/// 시각 높이 28 고정, 가로는 부모 폭을 채운다.
/// [error]가 있으면 밑줄이 에러 색으로 바뀌고 하단에 문구가 붙는다.
///
/// - [ProjectInput.text]: 직접 입력. [onRemove]가 있으면 오른쪽에 삭제(×) 버튼.
/// - [ProjectInput.date] / [ProjectInput.dropdown]: 탭 전용 표시 필드.
///   값이 없으면 [placeholder]를 보여주고, 탭하면 [onTap]으로 상위에서 날짜 선택·선택 목록을 연다.
///
/// | 옵션 | 설명 |
/// |---|---|
/// | [placeholder] | 플레이스홀더. |
/// | [error] | 에러 문구. null이면 Default 상태. |
/// | [controller] | text 전용. 입력값. |
/// | [onChanged] | text 전용. 입력 변경 콜백. |
/// | [maxLength] | text 전용. 최대 글자 수. |
/// | [onMaxLengthExceeded] | text 전용. 최대 글자 수를 넘겨 입력하려 할 때 호출. |
/// | [onRemove] | text 전용. 있으면 오른쪽에 삭제(×) 버튼을 표시. |
/// | [value] | date·dropdown 전용. 표시할 값(텍스트). null이면 placeholder. |
/// | [onTap] | date·dropdown 전용. 탭 콜백. |
class ProjectInput extends StatelessWidget {
  const ProjectInput.text({
    super.key,
    required TextEditingController this.controller,
    this.placeholder,
    this.error,
    this.onChanged,
    this.maxLength,
    this.onMaxLengthExceeded,
    this.onRemove,
  }) : type = ProjectInputType.text,
       value = null,
       onTap = null;

  const ProjectInput.date({
    super.key,
    required this.value,
    required VoidCallback this.onTap,
    this.placeholder,
    this.error,
  }) : type = ProjectInputType.date,
       controller = null,
       onChanged = null,
       maxLength = null,
       onMaxLengthExceeded = null,
       onRemove = null;

  const ProjectInput.dropdown({
    super.key,
    required this.value,
    required VoidCallback this.onTap,
    this.placeholder,
    this.error,
  }) : type = ProjectInputType.dropdown,
       controller = null,
       onChanged = null,
       maxLength = null,
       onMaxLengthExceeded = null,
       onRemove = null;

  final ProjectInputType type;
  final String? placeholder;
  final String? error;

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final VoidCallback? onMaxLengthExceeded;
  final VoidCallback? onRemove;

  final String? value;
  final VoidCallback? onTap;

  static const double _height = 28;

  static const Color _underlineColor = AppColors.border;
  static const double _underlineWidth = 1;
  static const Color _errorUnderlineColor = AppColors.error;
  static const double _errorUnderlineWidth = 1;

  static const Color _valueTextColor = AppColors.textSecondary;
  static const Color _placeholderTextColor = AppColors.grey200;
  static const Color _iconColor = AppColors.grey600;
  static const Color _errorTextColor = AppColors.error;

  static const double _errorMessageGap = AppSpacing.space4;

  // 아이콘이 차지하는 폭. 아이콘은 고정 폭 영역 안 가운데 정렬.
  // Date 48/20, Dropdown 28/24, 실 행 삭제(×) 48/20.
  static const double _dateIconSlotWidth = 48;
  static const double _dropdownIconSlotWidth = 28;
  static const double _removeIconSlotWidth = 48;

  bool get _hasError => error != null;

  _TrailingIcon? get _trailing => switch (type) {
    ProjectInputType.text =>
      onRemove == null
          ? null
          : (
              icon: Icons.close,
              size: AppIconSize.md,
              slotWidth: _removeIconSlotWidth,
            ),
    ProjectInputType.date => (
      icon: Icons.calendar_today_outlined,
      size: AppIconSize.md,
      slotWidth: _dateIconSlotWidth,
    ),
    ProjectInputType.dropdown => (
      icon: Icons.keyboard_arrow_down,
      size: AppIconSize.base,
      slotWidth: _dropdownIconSlotWidth,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildFrame(),
        if (_hasError) ...[
          const SizedBox(height: _errorMessageGap),
          Text(
            error!,
            style: AppTextStyles.body.copyWith(color: _errorTextColor),
          ),
        ],
      ],
    );
  }

  Widget _buildFrame() {
    final trailing = _trailing;

    final frame = Container(
      height: _height,
      alignment: Alignment.centerLeft,
      // 밑줄은 덧그린다(17px 글자 공간 유지).
      foregroundDecoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: _hasError ? _errorUnderlineColor : _underlineColor,
            width: _hasError ? _errorUnderlineWidth : _underlineWidth,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: type == ProjectInputType.text
                ? _buildTextField()
                : _buildValueText(),
          ),
          if (trailing != null) _buildTrailing(trailing),
        ],
      ),
    );

    if (type == ProjectInputType.text) return frame;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: frame,
    );
  }

  Widget _buildTrailing(_TrailingIcon t) {
    final slot = SizedBox(
      width: t.slotWidth,
      child: Center(
        child: Icon(t.icon, size: t.size, color: _iconColor),
      ),
    );

    // date, dropdown 아이콘은 필드 전체 탭에 포함되므로 그대로 둔다.
    if (type != ProjectInputType.text) return slot;

    // text의 ×는 독립 버튼(행 삭제).
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onRemove,
      child: slot,
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLength: maxLength,
      inputFormatters: maxLength == null
          ? null
          : [MaxLengthExceededFormatter(maxLength!, onMaxLengthExceeded)],
      cursorColor: _valueTextColor,
      style: ProjectFormTextStyles.body.copyWith(color: _valueTextColor),
      // 기본 테두리와 여백을 없애고, 글자 수 표시도 숨긴다.
      decoration: InputDecoration.collapsed(
        hintText: placeholder,
        hintStyle: ProjectFormTextStyles.body.copyWith(
          color: _placeholderTextColor,
        ),
      ).copyWith(counterText: ''),
    );
  }

  Widget _buildValueText() {
    final hasValue = value?.isNotEmpty ?? false;

    return Text(
      hasValue ? value! : (placeholder ?? ''),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: ProjectFormTextStyles.body.copyWith(
        color: hasValue ? _valueTextColor : _placeholderTextColor,
      ),
    );
  }
}
