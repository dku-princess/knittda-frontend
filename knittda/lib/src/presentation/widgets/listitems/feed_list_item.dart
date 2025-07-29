import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/models/feed_model.dart';

class FeedListItem extends StatefulWidget {
  final FeedModel feed;
  final VoidCallback onTap;

  const FeedListItem({
    super.key,
    required this.feed,
    required this.onTap,
  });

  @override
  State<FeedListItem> createState() => _FeedListItemState();
}

class _FeedListItemState extends State<FeedListItem> {
  late final PageController _pageCtrl;

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feed = widget.feed;
    final corrected = feed.record.createdAt!.add(const Duration(hours: 9));
    final dateStr = DateUtilsHelper.toDotFormat(corrected);
    final timeStr = DateUtilsHelper.toHourMinuteFormat(corrected);

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding:  const EdgeInsets.only(top: 20, bottom: 16, right: 24, left: 24),

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
                  radius: 20,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: feed.profileImageUrl != null ? NetworkImage(feed.profileImageUrl!) : null,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //사용자 이름, 작품이름
                      Row(
                        children: [
                          Text(
                            '${feed.userName ?? '탈퇴한 사용자'}  |  ${feed.projectName}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      //시간
                      Text(
                        '$dateStr $timeStr',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),

                      //사진
                      if (feed.record.images != null && feed.record.images!.isNotEmpty) ...[
                        AspectRatio(
                          aspectRatio: 3/2,
                          child: feed.record.images!.length == 1
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              feed.record.images!.first.imageUrl,
                              fit: BoxFit.cover,

                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                              },

                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade300,
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
                                );
                              },
                            ),
                          )
                              : PageView.builder(
                            key: PageStorageKey(feed.record.id),
                            controller: _pageCtrl,
                            itemCount: feed.record.images!.length,
                            padEnds: false,
                            itemBuilder: (context, index) {
                              final image = feed.record.images![index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    image.imageUrl,
                                    fit: BoxFit.cover,

                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
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
                        LayoutBuilder(
                          builder: (context, constraints) {
                            const double spacing = 8;          // 칩 사이 간격
                            const double plusChipWidth = 40;   // '+N' 칩 예상폭 (조금 넉넉히)
                            const double charWidth = 14;       // 한 글자 폭을 넉넉히(12 → 14) 잡는다
                            const double safety = 12;          // 남겨 두는 여유 폭

                            double usedWidth = 0;
                            int hidden = 0;
                            final List<Widget> chips = [];

                            for (int i = 0; i < feed.record.tags!.length; i++) {
                              final tag = feed.record.tags![i];
                              // padding + border까지 포함한 칩 폭 (보수적으로)
                              final double tagWidth = tag.length * charWidth + 32;

                              // 앞으로 남은 태그 수
                              final int remain = feed.record.tags!.length - i - 1;

                              // 남은 게 있으면 +N 칩 폭까지 미리 확보
                              final double reserve = remain > 0 ? spacing + plusChipWidth : 0;

                              // spacing 은 chips가 비어있지 않을 때만
                              final double nextSpacing = chips.isEmpty ? 0 : spacing;

                              if (usedWidth + nextSpacing + tagWidth + reserve > constraints.maxWidth - safety) {
                                hidden = feed.record.tags!.length - i;
                                break;                   // 더 못 넣음 → 탈출
                              }

                              // 칩 추가
                              if (chips.isNotEmpty) usedWidth += spacing;
                              usedWidth += tagWidth;
                              chips.add(_buildTagChip(tag));
                            }

                            if (hidden > 0) {
                              chips.add(_buildTagChip('+$hidden'));
                            }

                            // Wrap 으로 한 줄에만 배치 (폭 부족하면 알아서 줄바꿈, 하지만 보수적 계산 덕분에 99% 한 줄)
                            return Wrap(
                              spacing: spacing,
                              children: chips,
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
