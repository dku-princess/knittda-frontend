import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';

class FeedListItem extends StatelessWidget {

  const FeedListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tags = ['배색뜨기', '성공했어요', '힘들어요', '푸르시오', '메리아스뜨기', '무늬뜨기'];

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
            // 프로필
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '이름',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Text(
                            "2025.07.13 10:45",
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text('작품이름'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(left: 52),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  //사진
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey, // 배경색 회색
                      borderRadius: BorderRadius.circular(6), // 모서리 둥글게
                    ),
                  ),
                  const SizedBox(height: 10),

                  //본문
                  Text(
                    "코딩 학교 대학교 시험 종강",
                    style: const TextStyle(fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),

                  LayoutBuilder( //화면의 가로 너비를 알아내기 위해 사용
                    builder: (context, constraints) {
                      const double tagSpacing = 10;
                      double usedWidth = 0;
                      List<Widget> limitedTags = [];
                      int hiddenCount = 0;

                      for (final tag in tags) {
                        final tagWidth = (tag.length * 12) + 24;
                        final plusTagWidth = 40; // 대략적인 +N의 폭

                        if (usedWidth + tagWidth + plusTagWidth > constraints.maxWidth) {
                          hiddenCount = tags.length - limitedTags.length;
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

                ],
              ),
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
