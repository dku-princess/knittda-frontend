import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_dropdown.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_input.dart';
import 'package:knittda/src/presentation/project_add_edit/widgets/project_unit_toggle.dart';

/// 바늘 행 에러. 한 행에는 우선순위가 가장 높은 에러 하나만 표시한다.
enum NeedleRowError {
  missingType('바늘 종류를 선택해 주세요.', onType: true),
  missingSize('굵기를 입력해 주세요.', onType: false),
  invalidSize('0 이상의 숫자로 입력해 주세요.', onType: false);

  const NeedleRowError(this.message, {required this.onType});

  final String message;

  /// true면 종류 칸, false면 굵기 칸의 에러.
  final bool onType;
}

/// 작품 입력 화면의 NeedleRow 바늘 입력과 검증
///
/// 종류 · 굵기 · 단위 · 삭제(×) 순으로 놓는다. 굵기 칸은 남는 폭을 채운다.
/// [error]가 있으면 해당 칸의 밑줄만 빨갛게 하고, 문구는 행 아래 왼쪽 끝에 한 번만 표시한다.
///
/// | 옵션 | 설명 |
/// |---|---|
/// | [types] | 바늘 종류 목록. |
/// | [type] | 선택된 종류. null이면 미선택. |
/// | [typeLabelOf] | 종류를 화면 문구로 바꾼다. |
/// | [onTypeChanged] | 종류를 고를 때 호출. |
/// | [typesLoading] | 종류 목록을 불러오는 중인지. |
/// | [sizeController] | 굵기 입력값. |
/// | [unit] | 굵기 단위. |
/// | [onUnitChanged] | 단위를 바꿀 때 호출. |
/// | [error] | 행 에러. null이면 정상. |
/// | [onRemove] | ×를 탭할 때 호출. |
class ProjectNeedleRow<T> extends StatelessWidget {
  const ProjectNeedleRow({
    super.key,
    required this.types,
    required this.type,
    required this.typeLabelOf,
    required this.onTypeChanged,
    required this.sizeController,
    required this.unit,
    required this.onUnitChanged,
    required this.onRemove,
    this.typesLoading = false,
    this.error,
  });

  final List<T> types;
  final T? type;
  final String Function(T type) typeLabelOf;
  final ValueChanged<T> onTypeChanged;
  final bool typesLoading;
  final TextEditingController sizeController;
  final NeedleSizeUnit unit;
  final ValueChanged<NeedleSizeUnit> onUnitChanged;
  final NeedleRowError? error;
  final VoidCallback onRemove;

  static const double _typeWidth = 88;
  static const double _gap = AppSpacing.space8;
  static const double _removeSlotWidth = 48;

  static const String _typePlaceholder = '종류';
  static const int _sizeMaxLength = 5;

  @override
  Widget build(BuildContext context) {
    final error = this.error;

    // 에러가 난 칸은 밑줄만 빨갛게 하고(''), 문구는 행 아래에 한 번만 그린다.
    final typeError = error != null && error.onType ? '' : null;
    final sizeError = error != null && !error.onType ? '' : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SizedBox(
              width: _typeWidth,
              child: ProjectDropdown<T>(
                options: types,
                value: type,
                labelOf: typeLabelOf,
                onChanged: onTypeChanged,
                placeholder: _typePlaceholder,
                loading: typesLoading,
                error: typeError,
              ),
            ),
            const SizedBox(width: _gap),
            Expanded(
              child: ProjectInput.text(
                controller: sizeController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                maxLength: _sizeMaxLength,
                error: sizeError,
              ),
            ),
            const SizedBox(width: _gap),
            ProjectUnitToggle(value: unit, onChanged: onUnitChanged),
            const SizedBox(width: _gap),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onRemove,
              child: const SizedBox(
                width: _removeSlotWidth,
                height: ProjectInput.height,
                child: Center(
                  child: Icon(
                    Icons.close,
                    size: AppIconSize.md,
                    color: AppColors.grey600,
                  ),
                ),
              ),
            ),
          ],
        ),
        // ProjectInput의 에러 문구와 같은 모양(14px, 에러 색, 간격 4).
        if (error != null) ...[
          const SizedBox(height: AppSpacing.space4),
          Text(
            error.message,
            style: AppTextStyles.body.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}
