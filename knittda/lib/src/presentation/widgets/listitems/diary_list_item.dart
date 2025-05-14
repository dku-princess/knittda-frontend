import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';

class DiaryListItem extends StatelessWidget {
  final DateTime recordedAt;
  final List<XFile> images;
  final String comment;
  final List<String> tags;

  const DiaryListItem({
    super.key,
    required this.recordedAt,
    required this.images,
    required this.comment,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr = DateUtilsHelper.toDotFormat(recordedAt);

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 날짜
            Text(dateStr, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 16),

            /// 이미지 슬라이더
            if (images.isNotEmpty) ...[
              SizedBox(
                height: 200,
                child: PageView.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(images[index].path),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],

            /// 본문 (최대 3줄, 넘치면 ...)
            if (comment.isNotEmpty) ...[
              Text(
                comment,
                style: const TextStyle(fontSize: 16),
                maxLines: 3,
                overflow: TextOverflow.ellipsis, // ✅ ... 처리
              ),
              const SizedBox(height: 16),
            ],

            /// 태그 (한 줄만, 넘치면 ... 비슷한 시각적 처리)
            LayoutBuilder(
              builder: (context, constraints) {
                // 한 줄에 들어갈 수 있는 최대 너비 기준으로 태그 제한
                const double tagSpacing = 10;
                double usedWidth = 0;
                List<Widget> limitedTags = [];

                for (final tag in tags) {
                  final tagWidth = (tag.length * 12) + 24; // rough estimate
                  if (usedWidth + tagWidth > constraints.maxWidth) {
                    limitedTags.add(const Text('...', style: TextStyle(color: Colors.grey)));
                    break;
                  }
                  usedWidth += tagWidth + tagSpacing;

                  limitedTags.add(
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: PRIMARY_COLOR),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: PRIMARY_COLOR,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }

                return Wrap(
                  spacing: tagSpacing,
                  children: limitedTags,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
