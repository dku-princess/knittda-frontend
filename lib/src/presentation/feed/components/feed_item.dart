import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/domain/model/feed.dart';
import 'package:knittda/src/domain/model/images.dart';

class FeedItem extends StatelessWidget {
  final Feed feed;
  final VoidCallback onTap;
  const FeedItem({super.key, required this.feed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateUtilsHelper.toDotFormat(feed.record.createdAt!);
    final timeStr = DateUtilsHelper.toHourMinuteFormat(feed.record.createdAt!);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),

          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
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
                        color: Colors.grey[300],
                        child: Icon(Icons.person, color: Colors.grey),
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
                            color: Colors.grey[300],
                            child: Icon(Icons.person, color: Colors.grey),
                          );
                        },
                      ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //이름, 프로젝트 이름
                    Text(
                      '${feed.userName}  |  ${feed.projectName}',
                      style: const TextStyle(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),

                    //시간
                    Text(
                      '$dateStr $timeStr',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),

                    //사진
                    if (feed.record.images != null &&
                        feed.record.images!.isNotEmpty) ...[
                      _FeedImages(images: feed.record.images!),
                      const SizedBox(height: 16),
                    ],

                    //기록
                    if (feed.record.comment != null &&
                        feed.record.comment!.isNotEmpty) ...[
                      Text(
                        feed.record.comment!,
                        style: const TextStyle(fontSize: 14),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),
                    ],

                    if (feed.record.tags != null &&
                        feed.record.tags!.isNotEmpty) ...[
                      _FeedTags(tags: feed.record.tags!),
                      const SizedBox(height: 16),
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

  const _FeedImages({required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
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
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 40,
                ),
              );
            },
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
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
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
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 40,
                    ),
                  );
                },
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), // 완전 둥근 테두리
            border: Border.all(color: PRIMARY_COLOR, width: 1),
          ),
          child: Text(
            tag,
            style: const TextStyle(fontSize: 12, color: PRIMARY_COLOR),
          ),
        );
      }).toList(),
    );
  }
}
