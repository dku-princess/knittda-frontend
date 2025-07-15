import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/models/feed_model.dart';
import 'package:knittda/src/presentation/widgets/image_box.dart';

class FeedListItem extends StatelessWidget {
  final FeedModel feed;

  const FeedListItem({
    super.key,
    required this.feed,
  });

  @override
  Widget build(BuildContext context) {
    final corrected = feed.record.createdAt!.add(const Duration(hours: 9));
    final dateStr = DateUtilsHelper.toDotFormat(corrected);
    final timeStr = DateUtilsHelper.toHourMinuteFormat(corrected);

    return GestureDetector(
      onTap: (){},
      child: Container(
        //바닥 선
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),

        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //프로필 사진
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  backgroundImage: NetworkImage(feed.profileImageUrl),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${feed.userName}  |  ${feed.projectName}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      Text(
                        '$dateStr $timeStr',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),

                      //사진
                      if (feed.record.images != null && feed.record.images!.isNotEmpty) ...[
                        SizedBox(
                          height: 200,
                          child: feed.record.images!.length == 1
                              ? ImageBox(
                            networkImageUrl: feed.record.images!.first.imageUrl,
                            width: double.infinity,
                            height: 200,
                          )
                              : PageView.builder(
                            controller: PageController(viewportFraction: 0.5),
                            itemCount: feed.record.images!.length,
                            padEnds: false,
                            itemBuilder: (context, index) {
                              final image = feed.record.images![index];
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
                        const SizedBox(height: 10),
                      ],

                      //본문
                      if (feed.record.comment != null && feed.record.comment!.isNotEmpty) ...[
                        Text(
                          feed.record.comment!,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                      ],


                      if (feed.record.tags != null && feed.record.tags!.isNotEmpty) ...[
                        LayoutBuilder( //화면의 가로 너비를 알아내기 위해 사용
                          builder: (context, constraints) {
                            const double tagSpacing = 10;
                            double usedWidth = 0;
                            List<Widget> limitedTags = [];
                            int hiddenCount = 0;

                            for (final tag in feed.record.tags!) {
                              final tagWidth = (tag.length * 12) + 24;
                              final plusTagWidth = 40; // 대략적인 +N의 폭

                              if (usedWidth + tagWidth + plusTagWidth > constraints.maxWidth) {
                                hiddenCount = feed.record.tags!.length - limitedTags.length;
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
                        const SizedBox(height: 10),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
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
