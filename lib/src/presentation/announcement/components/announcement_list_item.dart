import 'package:flutter/material.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/domain/model/announcement.dart';

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
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF4D4D4D),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF0ABE8C),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                announcement.categoryLabel,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(width: 8),
            Text(
              announcement.publishedAt != null
                  ? DateUtilsHelper.toDotFormat(announcement.publishedAt!)
                  : '',
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFFA6A6A6),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
