import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/knittda_network_image.dart';
import 'package:knittda/src/presentation/widgets/knittda_chip.dart';
import 'package:knittda/src/domain/model/article/article.dart';
import 'package:knittda/src/core/theme/theme.dart';

class ArticleCardSmall extends StatelessWidget {
  final Article article;
  final String? imageUrl;

  const ArticleCardSmall({
    super.key,
    required this.article,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width * 0.3;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.space12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.card),
            child: SizedBox(
              width: imageWidth,
              height: imageWidth * 10 / 9,
              child: KnittdaNetworkImage(
                url: imageUrl,
                backgroundColor: AppColors.grey100,
                placeholderIcon: Icons.image_not_supported,
                iconSize: AppIconSize.base,
                showLoading: false,
              ),
            ),
          ),
        ),

        Expanded(
          child: SizedBox(
            height: imageWidth * 10 / 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (article.category.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.space4),
                    child: KnittdaChip(label: article.category),
                  ),

                if (article.title.isNotEmpty)
                  Text(
                    article.title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppFontSize.lg,
                      fontWeight: AppFontWeight.semibold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                Spacer(),
                if (article.interviewee.isNotEmpty) ...[
                  Text(
                    article.interviewee,
                    style: TextStyle(fontSize: AppFontSize.md, color: AppColors.grey600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

