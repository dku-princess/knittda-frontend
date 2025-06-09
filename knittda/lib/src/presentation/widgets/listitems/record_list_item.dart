import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/presentation/widgets/image_box.dart';

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

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 날짜
            Row(
              children: [
                Text(dateStr, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(width: 10),
                Text(timeStr, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),

            // 이미지들
            if (record.images != null && record.images!.isNotEmpty) ...[
              SizedBox(
                height: 200,
                child: record.images!.length == 1
                    ? ImageBox(
                  networkImageUrl: record.images!.first.imageUrl,
                  width: double.infinity,
                  height: 200,
                )
                    : PageView.builder(
                  controller: PageController(viewportFraction: 0.85),
                  itemCount: record.images!.length,
                  padEnds: false,
                  itemBuilder: (context, index) {
                    final image = record.images![index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ImageBox(
                        networkImageUrl: image.imageUrl,
                        width: double.infinity,
                        height: 200,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],


            // 본문
            if (record.comment != null && record.comment!.isNotEmpty) ...[
              Text(
                record.comment!,
                style: const TextStyle(fontSize: 16),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
            ],

            // 태그
            if (record.tags != null && record.tags!.isNotEmpty) ...[
              LayoutBuilder( //화면의 가로 너비를 알아내기 위해 사용
                builder: (context, constraints) {
                  const double tagSpacing = 10;
                  double usedWidth = 0;
                  List<Widget> limitedTags = [];
                  int hiddenCount = 0;

                  for (final tag in record.tags!) {
                    final tagWidth = (tag.length * 12) + 24; //각 태그의 대략적인 너비 계산
                    //현재까지 너비 + 이번 태그 더했을 때 화면 너비 초과하면, 남은 태구 개수를 +N 형태로 계산
                    if (usedWidth + tagWidth > constraints.maxWidth) {
                      hiddenCount = record.tags!.length - limitedTags.length;
                      if (hiddenCount > 0) {
                        limitedTags.add(_buildTagChip('+$hiddenCount'));
                      }
                      break;
                    }
                    usedWidth += tagWidth + tagSpacing;
                    limitedTags.add(_buildTagChip(tag));
                  }

                  return Wrap(
                    spacing: tagSpacing,
                    children: limitedTags,
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTagChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
