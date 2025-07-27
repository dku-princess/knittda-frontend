import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/models/feed_model.dart';
import 'package:knittda/src/presentation/widgets/image_viewer_screen.dart';

class FeedListItem extends StatelessWidget {
  final FeedModel feed;
  final VoidCallback onTap;

  const FeedListItem({
    super.key,
    required this.feed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final corrected = feed.record.createdAt!.add(const Duration(hours: 9));
    final dateStr = DateUtilsHelper.toDotFormat(corrected);
    final timeStr = DateUtilsHelper.toHourMinuteFormat(corrected);
    final imageUrls = feed.record.images!.map((e) => e.imageUrl).toList();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 프로필 사진
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[300],
                  child: ClipOval(
                    child: Image.network(
                      feed.profileImageUrl,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          alignment: Alignment.center,
                          child: const Icon(Icons.person, size: 24, color: Colors.white),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // 사용자 정보 + 기록
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${feed.userName}  |  ${feed.projectName}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$dateStr $timeStr',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),

                      // 이미지
                      if (feed.record.images != null && feed.record.images!.isNotEmpty) ...[
                        SizedBox(
                          height: 200,
                          child: feed.record.images!.length == 1
                              ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ImageViewerScreen(
                                    imageUrls: imageUrls,
                                    initialIndex: 0,
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                imageUrls.first,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade300,
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
                                  );
                                },
                              ),
                            ),
                          )
                              : PageView.builder(
                            controller: PageController(viewportFraction: 0.6),
                            itemCount: imageUrls.length,
                            padEnds: false,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ImageViewerScreen(
                                          imageUrls: imageUrls,
                                          initialIndex: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                      imageUrls[index],
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey.shade300,
                                          alignment: Alignment.center,
                                          child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],

                      // 코멘트
                      if (feed.record.comment != null && feed.record.comment!.isNotEmpty) ...[
                        Text(
                          feed.record.comment!,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                      ],

                      // 태그
                      if (feed.record.tags != null && feed.record.tags!.isNotEmpty) ...[
                        LayoutBuilder(
                          builder: (context, constraints) {
                            const double spacing = 8;
                            const double plusChipWidth = 40;
                            const double charWidth = 14;
                            const double safety = 12;

                            double usedWidth = 0;
                            int hidden = 0;
                            final List<Widget> chips = [];

                            for (int i = 0; i < feed.record.tags!.length; i++) {
                              final tag = feed.record.tags![i];
                              final double tagWidth = tag.length * charWidth + 32;
                              final int remain = feed.record.tags!.length - i - 1;
                              final double reserve = remain > 0 ? spacing + plusChipWidth : 0;
                              final double nextSpacing = chips.isEmpty ? 0 : spacing;

                              if (usedWidth + nextSpacing + tagWidth + reserve > constraints.maxWidth - safety) {
                                hidden = feed.record.tags!.length - i;
                                break;
                              }

                              if (chips.isNotEmpty) usedWidth += spacing;
                              usedWidth += tagWidth;
                              chips.add(_buildTagChip(tag));
                            }

                            if (hidden > 0) {
                              chips.add(_buildTagChip('+$hidden'));
                            }

                            return Wrap(
                              spacing: spacing,
                              children: chips,
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: PRIMARY_COLOR),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: PRIMARY_COLOR,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }
}
