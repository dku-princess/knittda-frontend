import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/knittda_network_image.dart';
import 'package:knittda/src/presentation/widgets/knittda_tag.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/domain/model/images.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:knittda/src/core/theme/theme.dart';

class RecordItem extends StatelessWidget {
  final Records record;
  final VoidCallback onTap;
  final void Function(int index, List<Images> images)? onImageTap;
  const RecordItem({
    super.key,
    required this.record,
    required this.onTap,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr = DateUtilsHelper.toDotFormat(record.createdAt!);
    final timeStr = DateUtilsHelper.toHourMinuteFormat(record.createdAt!);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space32),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.space20),

          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.grey200)),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //날짜 시간
              Text(
                '$dateStr $timeStr',
                style: AppTextStyles.caption,
              ),
              const SizedBox(height: AppSpacing.space12),

              //사진
              if (record.images != null && record.images!.isNotEmpty) ...[
                _RecordImages(
                  images: record.images!,
                  onImageTap: (index) {
                    if (onImageTap != null) {
                      onImageTap!(index, record.images!);
                    }
                  },
                ),
                const SizedBox(height: AppSpacing.space16),
              ],

              //기록
              if (record.comment != null && record.comment!.isNotEmpty) ...[
                Text(
                  record.comment!,
                  style: AppTextStyles.body,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.space16),
              ],

              //태그
              if (record.tags != null && record.tags!.isNotEmpty) ...[
                _RecordTags(tags: record.tags!),
                const SizedBox(height: AppSpacing.space12),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _RecordImages extends StatelessWidget {
  final List<Images> images;
  final void Function(int index)? onImageTap;

  const _RecordImages({required this.images, this.onImageTap});

  @override
  Widget build(BuildContext context) {
    if (images.length == 1) {
      return GestureDetector(
        onTap: () {
          onImageTap?.call(0);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: KnittdaNetworkImage(
              url: images.first.imageUrl,
              placeholderIcon: Icons.broken_image,
            ),
          ),
        ),
      );
    }

    // 여러 장일 경우
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.9),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onImageTap?.call(index);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: AppSpacing.space8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.card),
                child: KnittdaNetworkImage(
                  url: images[index].imageUrl,
                  placeholderIcon: Icons.broken_image,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RecordTags extends StatelessWidget {
  final List<String> tags;
  const _RecordTags({required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8, // 태그 사이 가로 간격
      runSpacing: 10, // 줄 바뀔 때 세로 간격
      children: tags.map((tag) {
        return KnittdaTag(label: tag);
      }).toList(),
    );
  }
}
