import 'package:flutter/material.dart';
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
                style: const TextStyle(fontSize: AppFontSize.sm, color: AppColors.grey400),
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
                  style: const TextStyle(fontSize: AppFontSize.md),
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
            child: Image.network(
              images.first.imageUrl,
              fit: BoxFit.cover,

              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              },

              errorBuilder: (context, exception, stackTrace) {
                return Container(
                  color: AppColors.grey200,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.broken_image,
                    color: AppColors.grey400,
                    size: 40,
                  ),
                );
              },
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
                child: Image.network(
                  images[index].imageUrl,
                  fit: BoxFit.cover,

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  },

                  errorBuilder: (context, exception, stackTrace) {
                    return Container(
                      color: AppColors.grey200,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.broken_image,
                        color: AppColors.grey400,
                        size: 40,
                      ),
                    );
                  },
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
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space8, vertical: AppSpacing.space8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.pill), // 완전 둥근 테두리
            border: Border.all(color: PRIMARY_COLOR, width: 1),
          ),
          child: Text(
            tag,
            style: const TextStyle(fontSize: AppFontSize.sm, color: PRIMARY_COLOR),
          ),
        );
      }).toList(),
    );
  }
}
