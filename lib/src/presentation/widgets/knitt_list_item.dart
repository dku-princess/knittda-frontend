import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// Knittda 공통 리스트 항목. Figma `ListItem` 컴포넌트와 대응.
///
/// 썸네일 + 제목([AppTextStyles.body]) + 부제([AppTextStyles.caption]) + 우측 chevron.
/// 높이/패딩/하단 divider를 디자인 토큰으로 구성.
class KnittListItem extends StatelessWidget {
  const KnittListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.onTap,
    this.showChevron = true,
  });

  final String title;
  final String? subtitle;

  /// 좌측 위젯. 없으면 40x40 썸네일 플레이스홀더.
  final Widget? leading;
  final VoidCallback? onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(bottom: BorderSide(color: AppColors.border)),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space16,
          vertical: AppSpacing.space12,
        ),
        child: Row(
          children: [
            leading ?? _thumbnail(),
            const SizedBox(width: AppSpacing.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: AppTextStyles.body),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!, style: AppTextStyles.caption),
                  ],
                ],
              ),
            ),
            if (showChevron)
              const Icon(
                Icons.chevron_right,
                size: 22,
                color: AppColors.textHint,
              ),
          ],
        ),
      ),
    );
  }

  Widget _thumbnail() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
    );
  }
}
