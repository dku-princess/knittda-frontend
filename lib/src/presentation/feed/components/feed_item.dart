import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/domain/model/feed.dart';
import 'package:knittda/src/domain/model/images.dart';
import 'package:knittda/src/core/theme/theme.dart';

class FeedItem extends StatelessWidget {
  final Feed feed;
  final VoidCallback onTap;
  final void Function(int index, List<Images> images)? onImageTap;

  const FeedItem({
    super.key,
    required this.feed,
    required this.onTap,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr = DateUtilsHelper.toDotFormat(feed.record.createdAt!);
    final timeStr = DateUtilsHelper.toHourMinuteFormat(feed.record.createdAt!);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space32),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.space20),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.grey200)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //프로필 사진
              ClipOval(
                child:
                    (feed.profileImageUrl == null ||
                        feed.profileImageUrl!.isEmpty)
                    ? Container(
                        width: 40,
                        height: 40,
                        color: AppColors.grey200,
                        child: Icon(Icons.person, color: AppColors.grey400),
                      )
                    : Image.network(
                        feed.profileImageUrl!,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 40,
                            height: 40,
                            color: AppColors.grey200,
                            child: Icon(Icons.person, color: AppColors.grey400),
                          );
                        },
                      ),
              ),

              const SizedBox(width: AppSpacing.space12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //이름, 프로젝트 이름
                    Text(
                      '${feed.userName ?? '알 수 없음'}  |  ${feed.projectName}',
                      style: const TextStyle(fontSize: AppFontSize.md),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.space16),

                    //시간
                    Text(
                      '$dateStr $timeStr',
                      style: const TextStyle(fontSize: AppFontSize.sm, color: AppColors.grey400),
                    ),
                    const SizedBox(height: AppSpacing.space12),

                    //사진
                    if (feed.record.images != null &&
                        feed.record.images!.isNotEmpty) ...[
                      _FeedImages(
                        images: feed.record.images!,
                        onImageTap: (index) {
                          if (onImageTap != null) {
                            onImageTap!(index, feed.record.images!);
                          }
                        },
                      ),
                      const SizedBox(height: AppSpacing.space16),
                    ],

                    //기록
                    if (feed.record.comment != null &&
                        feed.record.comment!.isNotEmpty) ...[
                      Text(
                        feed.record.comment!,
                        style: const TextStyle(fontSize: AppFontSize.md),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.space16),
                    ],

                    if (feed.record.tags != null &&
                        feed.record.tags!.isNotEmpty) ...[
                      _FeedTags(tags: feed.record.tags!),
                      const SizedBox(height: AppSpacing.space16),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedImages extends StatelessWidget {
  final List<Images> images;
  final void Function(int index)? onImageTap;

  const _FeedImages({required this.images, this.onImageTap});

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
                    size: AppIconSize.xl,
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
                        size: AppIconSize.xl,
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

class _FeedTags extends StatelessWidget {
  final List<String> tags;
  const _FeedTags({required this.tags});

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
