import 'dart:io';

import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/models/record_model.dart';

class RecordListItem extends StatelessWidget {
  final RecordModel record;
  final VoidCallback onTap;

  const RecordListItem({
    super.key,
    required this.record,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr = DateUtilsHelper.toDotFormat(record.createdAt!);
    final timeStr = DateUtilsHelper.toHourMinuteFormat(record.createdAt!);
    final images = (record.images ?? []).take(5).toList();
    final isSingleImage = images.length == 1;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300), //bottom 외각선
          ),
        ),
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

            // 이미지 슬라이더
            if (record.images != null && record.images!.isNotEmpty) ...[
              SizedBox(
                height: 200,
                child: PageView.builder(
                  //itemCount: record.images!.length,
                  itemCount: record.images!.length > 5 ? 5 : record.images!.length,
                  itemBuilder: (context, index) {
                    final image = record.images![index];
                    return  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        image.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Icon(Icons.broken_image));
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],

            /// 본문
            if (record.comment != null && record.comment!.isNotEmpty) ...[
              Text(
                record.comment ?? '',
                style: const TextStyle(fontSize: 16),
                maxLines: 3, //최대 3줄
                overflow: TextOverflow.ellipsis, //넘기면 ...표시
              ),
              const SizedBox(height: 16),
            ],

            // 태그
            if (record.tags != null && record.tags!.isNotEmpty) ...[
              LayoutBuilder(
                builder: (context, constraints) {
                  const double tagSpacing = 10; //태그 간의 간격
                  double usedWidth = 0; //지금까지 사용한 너비 누적 계산
                  List<Widget> limitedTags = []; //실제 화면에 보여줄 태그들
                  int hiddenCount = 0; //숨겨진 태그의 개수

                  //태그 너비 계산 및 제한 로직
                  for (final tag in record.tags!) {
                    final tagWidth = (tag.length * 12) + 24; // 태그 하나가 차지할 너비
                    if (usedWidth + tagWidth > constraints.maxWidth) {
                      hiddenCount = record.tags!.length - limitedTags.length;
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
              SizedBox(height: 16,),
            ],
          ],
        ),
      ),
    );
  }
}
