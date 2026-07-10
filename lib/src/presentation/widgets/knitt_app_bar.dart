import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// Knittda 공통 앱바. Figma `AppBar` 컴포넌트와 대응.
///
/// 높이 56, 흰 배경, 하단 divider. 뒤로가기·제목([AppTextStyles.heading])·
/// 우측 액션([AppColors.primary])으로 구성.
class KnittAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KnittAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final VoidCallback? onBack;
  final String? actionLabel;
  final VoidCallback? onAction;

  static const double _height = 56;

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
      child: Row(
        children: [
          if (onBack != null) ...[
            GestureDetector(
              onTap: onBack,
              behavior: HitTestBehavior.opaque,
              child: const Icon(
                Icons.chevron_left,
                size: 28,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: AppSpacing.space8),
          ],
          Expanded(child: Text(title, style: AppTextStyles.heading)),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              behavior: HitTestBehavior.opaque,
              child: Text(
                actionLabel!,
                style: AppTextStyles.body.copyWith(color: AppColors.primary),
              ),
            ),
        ],
      ),
    );
  }
}
