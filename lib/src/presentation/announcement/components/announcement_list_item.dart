import 'package:flutter/material.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/domain/model/announcement.dart';
import 'package:knittda/src/core/theme/theme.dart';
import 'package:knittda/src/presentation/widgets/knittda_chip.dart';

class AnnouncementListItem extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementListItem({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          announcement.title ?? '',
          style: AppTextStyles.bodyStrong.copyWith(color: AppColors.grey800),
        ),
        const SizedBox(height: AppSpacing.space8),

        Row(
          children: [
            KnittdaChip(label: announcement.categoryLabel),

            const SizedBox(width: AppSpacing.space8),
            Text(
              announcement.publishedAt != null
                  ? DateUtilsHelper.toDotFormat(announcement.publishedAt!)
                  : '',
              style: const TextStyle(
                fontSize: AppFontSize.xs,
                color: AppColors.grey400,
                fontWeight: AppFontWeight.regular,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
