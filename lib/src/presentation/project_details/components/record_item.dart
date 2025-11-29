import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/domain/model/images.dart';
import 'package:knittda/src/domain/model/records.dart';

class RecordItem extends StatelessWidget {
  final Records record;
  final VoidCallback onTap;
  const RecordItem({super.key, required this.record, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateUtilsHelper.toDotFormat(record.createdAt!);
    final timeStr = DateUtilsHelper.toHourMinuteFormat(record.createdAt!);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding:  const EdgeInsets.only(top: 20, bottom: 20, right: 24, left: 24),

        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //날짜 시간
            Text(
              '$dateStr $timeStr',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),

            //사진
            if (record.images != null &&
                record.images!.isNotEmpty) ...[
              _RecordImages(images: record.images!),
              const SizedBox(height: 16),
            ],

            //기록
            if (record.comment != null &&
                record.comment!.isNotEmpty) ...[
              Text(
                record.comment!,
                style: const TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
            ],

            //태그
            if (record.tags != null && record.tags!.isNotEmpty) ...[
              _RecordTags(tags: record.tags!),
              const SizedBox(height: 10),
            ]
          ],
        ),
      ),
    );
  }
}

class _RecordImages extends StatelessWidget {
  final List<Images> images;

  const _RecordImages({required this.images});

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
        controller: PageController(
          viewportFraction: 0.9,
        ),
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

class _RecordTags extends StatelessWidget {
  final List<String> tags;
  const _RecordTags({required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,      // 태그 사이 가로 간격
      runSpacing: 10,   // 줄 바뀔 때 세로 간격
      children: tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), // 완전 둥근 테두리
            border: Border.all(
              color: PRIMARY_COLOR,
              width: 1,
            ),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              fontSize: 12,
              color: PRIMARY_COLOR,
            ),
          ),
        );
      }).toList(),
    );
  }
}