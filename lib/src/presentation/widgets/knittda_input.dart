import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// Knittda 공통 입력 필드. Figma `Input` 컴포넌트와 대응.
///
/// 상태(기본/포커스/에러) 테두리는 Flutter가 자동 처리한다.
/// - 기본: [AppColors.border] / 포커스: [AppColors.primary] / 에러: [AppColors.error]
///
/// | 옵션 | 설명 |
/// |---|---|
/// | [controller] | 텍스트 컨트롤러. |
/// | [hintText] | 플레이스홀더. |
/// | [errorText] | 에러 문구(있으면 에러 테두리). |
/// | [onChanged] | 입력 변경 콜백. |
/// | [obscureText] | 비밀번호 마스킹. |
/// | [keyboardType] | 키보드 타입(멀티라인 등). |
/// | [maxLines] | 최대 줄 수(기본 1). |
/// | [maxLength] | 최대 글자 수(카운터 표시). |
/// | [enabled] | false면 비활성. |
///
/// 아이콘(prefix/suffix)이 필요한 검색창 등은 이 위젯 대신 로컬 구성한다.
class KnittdaInput extends StatelessWidget {
  const KnittdaInput({
    super.key,
    this.controller,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? maxLength;
  final bool enabled;

  OutlineInputBorder _border(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.button),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLength,
      enabled: enabled,
      cursorColor: AppColors.primary,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: AppColors.white,
        hintText: hintText,
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint),
        errorText: errorText,
        errorStyle: AppTextStyles.caption.copyWith(color: AppColors.error),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space12,
        ),
        enabledBorder: _border(AppColors.border),
        focusedBorder: _border(AppColors.primary, 1.5),
        errorBorder: _border(AppColors.error, 1.5),
        focusedErrorBorder: _border(AppColors.error, 1.5),
      ),
    );
  }
}
