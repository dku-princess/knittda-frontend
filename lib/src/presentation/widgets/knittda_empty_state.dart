import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// Knittda 공통 빈 상태 / 결과 없음 표시.
///
/// 리스트가 비었거나 대상을 찾지 못했을 때 화면 중앙에 안내를 그린다.
/// 색·크기를 토큰으로 고정한다(메시지 `lg`·`grey400`).
///
/// | 옵션 | 설명 |
/// |---|---|
/// | [message] | 안내 문구 (필수). 중앙 정렬. |
/// | [icon] | 문구 위 아이콘(선택, `grey400`·[AppIconSize.xl]). |
/// | [action] | 문구 아래 액션 위젯(선택, 예: 새로고침 버튼). |
class KnittdaEmptyState extends StatelessWidget {
  const KnittdaEmptyState({
    super.key,
    required this.message,
    this.icon,
    this.action,
  });

  final String message;
  final IconData? icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: AppIconSize.xl, color: AppColors.grey400),
            const SizedBox(height: AppSpacing.space16),
          ],
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: AppFontSize.lg,
              color: AppColors.grey400,
            ),
          ),
          if (action != null) ...[
            const SizedBox(height: AppSpacing.space20),
            action!,
          ],
        ],
      ),
    );
  }
}
