import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/presentation/widgets/image_viewer_screen.dart';

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
    final corrected = record.createdAt!.add(const Duration(hours: 9));
    final dateStr = DateUtilsHelper.toDotFormat(corrected);
    final timeStr = DateUtilsHelper.toHourMinuteFormat(corrected);

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
            // 이미지들
            if (record.images != null && record.images!.isNotEmpty) ...[
              SizedBox(
                height: 200,
                child: record.images!.length == 1
                    ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ImageViewerScreen(
                          imageUrl: record.images!.first.imageUrl,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      record.images!.first.imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
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
                  controller: PageController(viewportFraction: 0.85),
                  itemCount: record.images!.length,
                  padEnds: false,
                  itemBuilder: (context, index) {
                    final image = record.images![index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ImageViewerScreen(
                                imageUrl: image.imageUrl,
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            image.imageUrl,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              );
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
