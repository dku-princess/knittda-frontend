import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// Knittda 공통 앱바. Figma `AppBar` 컴포넌트와 대응.
///
/// 앱의 4가지 앱바 패턴을 하나로 흡수한다.
/// - **대형 타이틀 랜딩**: [large]=true (display 24·좌측·뒤로가기 없음). `showBack: false`.
/// - **상세/편집**: [title] + 자동 뒤로가기 + [actions](저장 버튼 등).
/// - **back-only**: 인자 없이 뒤로가기만.
/// - **아이콘/팝업 액션**: [actions]에 위젯 전달.
///
/// 배경 흰색·`scrolledUnderElevation: 0`이 기본. 색·타이포는 디자인 토큰 기반.
class KnittdaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KnittdaAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.large = false,
    this.centerTitle,
    this.showBack = true,
    this.onBack,
    this.actions = const [],
    this.backgroundColor,
    this.titleStyle,
    this.titleSpacing,
    this.toolbarHeight,
  });

  /// 표시할 제목. null이면 제목 없는 앱바(back-only·아이콘 액션 전용).
  final String? title;

  /// 제목 자리에 커스텀 위젯(검색 필드 등)을 넣을 때 사용. [title]보다 우선.
  final Widget? titleWidget;

  /// 대형 랜딩 타이틀(display 24·좌측 정렬·titleSpacing 30) 여부.
  final bool large;

  /// null이면 플랫폼 기본. 편집화면은 보통 true.
  final bool? centerTitle;

  /// 뒤로가기(leading) 노출 여부. 랜딩 탭 화면은 false.
  final bool showBack;

  /// 커스텀 뒤로가기 핸들러. 지정 시 chevron 아이콘으로 노출.
  /// 미지정 + [showBack]이면 Material 기본 뒤로가기(자동 pop)를 사용.
  final VoidCallback? onBack;

  /// 우측 액션(저장 버튼·아이콘·팝업 메뉴 등).
  final List<Widget> actions;

  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final double? titleSpacing;
  final double? toolbarHeight;

  double get _height => toolbarHeight ?? kToolbarHeight;

  @override
  Size get preferredSize => Size.fromHeight(_height);

  TextStyle get _resolvedTitleStyle =>
      titleStyle ??
      TextStyle(
        fontSize: large ? AppFontSize.display : AppFontSize.xl,
        fontWeight: AppFontWeight.semibold,
        color: AppColors.textPrimary,
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.white,
      scrolledUnderElevation: 0,
      toolbarHeight: _height,
      automaticallyImplyLeading: showBack,
      leading: (showBack && onBack != null)
          ? IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: AppColors.textPrimary,
              ),
              onPressed: onBack,
            )
          : null,
      centerTitle: centerTitle ?? false,
      titleSpacing: titleSpacing ?? (large ? 30 : null),
      title: titleWidget ??
          (title != null ? Text(title!, style: _resolvedTitleStyle) : null),
      actions: actions.isEmpty ? null : actions,
    );
  }
}
