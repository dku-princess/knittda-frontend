import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/domain/model/article/article.dart';
import 'package:knittda/src/core/theme/theme.dart';

class ArticleCardLarge extends StatelessWidget {
  final Article article;
  final String? imageUrl;

  const ArticleCardLarge({super.key, required this.article, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: AspectRatio(
        aspectRatio: 8 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (imageUrl != null)
              Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.grey100,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: AppColors.grey400,
                      size: 36,
                    ),
                  );
                },
              )
            else
              Container(
                color: AppColors.grey100,
                child: const Icon(Icons.image, color: AppColors.grey400, size: 36),
              ),

            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.transparent,
                      AppColors.transparent,
                      PRIMARY_COLOR,
                    ],
                    stops: const [0.0, 0.4, 1.0],
                  ),
                ),
              ),
            ),

            Positioned(
              left: 20,
              bottom: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (article.interviewee.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.space8),
                      child: Text(
                        article.interviewee,
                        style: const TextStyle(
                          fontSize: AppFontSize.lg,
                          color: AppColors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],

                  if (article.title.isNotEmpty)
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontSize: AppFontSize.xl,
                        fontWeight: AppFontWeight.semibold,
                        color: AppColors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
