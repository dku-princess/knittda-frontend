import 'package:flutter/material.dart';
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
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.grey100,
                          child: const Icon(
                            Icons.image_not_supported,
                            color: AppColors.grey400,
                          ),
                        );
                      },
                    )
                  : Container(
                      alignment: Alignment.center,
                      color: AppColors.grey100,
                      child: const Text(
                        '이미지 준비 중',
                        style: TextStyle(fontSize: AppFontSize.sm),
                      ),
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
                    child: _CategoryTag(category: article.category),
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

class _CategoryTag extends StatelessWidget {
  final String category;

  const _CategoryTag({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space8, vertical: AppSpacing.space8),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Text(
        category,
        style: const TextStyle(fontSize: AppFontSize.sm, color: AppColors.white),
      ),
    );
  }
}
