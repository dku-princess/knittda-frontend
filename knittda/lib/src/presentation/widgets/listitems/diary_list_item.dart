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
    final timeStr = DateUtilsHelper.toHourMinuteFormat(recordedAt);

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 날짜
            Row(
              children: [
                Text(dateStr, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(width: 10,),
                Text(timeStr, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),

            /// 이미지 슬라이더
            if (images.isNotEmpty) ...[
              SizedBox(
                height: 200,
                child: PageView.builder( //가로로 넘기는 슬라이더
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4), //이미지들 간의 간격
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

            /// 본문
            if (comment.isNotEmpty) ...[
              Text(
                comment,
                style: const TextStyle(fontSize: 16),
                maxLines: 3, //최대 3줄
                overflow: TextOverflow.ellipsis, //넘기면 ...표시
              ),
              const SizedBox(height: 16),
            ],

            // 태그
            LayoutBuilder(
              builder: (context, constraints) {
                const double tagSpacing = 10; //태그 간의 간격
                double usedWidth = 0; //지금까지 사용한 너비 누적 계산
                List<Widget> limitedTags = []; //실제 화면에 보여줄 태그들
                int hiddenCount = 0; //숨겨진 태그의 개수

                //태그 너비 계산 및 제한 로직
                for (final tag in tags) {
                  final tagWidth = (tag.length * 12) + 24; // 태그 하나가 차지할 너비
                  if (usedWidth + tagWidth > constraints.maxWidth) {
                    hiddenCount = tags.length - limitedTags.length;
                    if (hiddenCount > 0) {
                      limitedTags.add(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(color: PRIMARY_COLOR),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '+$hiddenCount',
                            style: const TextStyle(
                              color: PRIMARY_COLOR,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    }
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
