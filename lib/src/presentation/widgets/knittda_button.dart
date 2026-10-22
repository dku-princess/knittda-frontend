import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// 버튼 스타일. Figma `Button` 컴포넌트의 Style 변형과 1:1.
enum KnittdaButtonStyle { primary, secondary, text }

/// Knittda 공통 버튼.
///
/// 색·패딩·모서리를 전부 디자인 토큰으로 구성한다. `onPressed`가 null이면
/// 비활성(disabled) 상태로 렌더된다.
///
/// | 옵션 | 설명 |
/// |---|---|
/// | [label] | 버튼 텍스트 (bodyStrong). |
/// | [onPressed] | 탭 콜백. null이면 비활성 렌더. |
/// | [style] | primary(초록 채움) / secondary(흰 배경+테두리) / text(투명). |
/// | [expanded] | true면 가로 100% 채움. |
///
/// 모서리는 항상 [AppRadius.button](8). pill·특수 모양 CTA는 이 위젯 대신
/// 로컬 스타일을 쓴다(문서 참고).
class KnittdaButton extends StatelessWidget {
  const KnittdaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.style = KnittdaButtonStyle.primary,
    this.expanded = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final KnittdaButtonStyle style;

  /// true면 가로로 꽉 채운다.
  final bool expanded;

  bool get _enabled => onPressed != null;

  @override
  Widget build(BuildContext context) {
    final _Palette p = _paletteFor(style, _enabled);

    final Widget button = Material(
      color: p.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.button),
        side: p.border == null
            ? BorderSide.none
            : BorderSide(color: p.border!),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadius.button),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space20,
            vertical: AppSpacing.space12,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyStrong.copyWith(color: p.foreground),
          ),
        ),
      ),
    );

    if (!expanded) return button;
    return SizedBox(width: double.infinity, child: button);
  }

  static _Palette _paletteFor(KnittdaButtonStyle style, bool enabled) {
    switch (style) {
      case KnittdaButtonStyle.primary:
        return _Palette(
          background: enabled ? AppColors.primary : AppColors.grey400,
          foreground: AppColors.white,
        );
      case KnittdaButtonStyle.secondary:
        return _Palette(
          background: AppColors.white,
          foreground: enabled ? AppColors.primary : AppColors.textHint,
          border: enabled ? AppColors.border : AppColors.grey200,
        );
      case KnittdaButtonStyle.text:
        return _Palette(
          background: AppColors.transparent,
          foreground: enabled ? AppColors.primary : AppColors.textHint,
        );
    }
  }
}

class _Palette {
  const _Palette({
    required this.background,
    required this.foreground,
    this.border,
  });

  final Color background;
  final Color foreground;
  final Color? border;
}
