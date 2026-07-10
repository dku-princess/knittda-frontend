import 'package:flutter/material.dart';
import 'package:knittda/src/domain/model/project_previews.dart';
import 'package:knittda/src/core/theme/theme.dart';

class ProjectPreviewsItem extends StatelessWidget {
  final ProjectPreviews projectPreviews;
  final VoidCallback onTap;

  const ProjectPreviewsItem({
    super.key,
    required this.projectPreviews,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String? imageUrl =
        (projectPreviews.recentImageUrl?.isNotEmpty ?? false)
        ? projectPreviews.recentImageUrl
        : null;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.card)),
      color: AppColors.white,
      elevation: AppElevation.card,
      shadowColor: AppColors.black,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                color: AppColors.grey200,
                alignment: Alignment.center,
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,

                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return CircularProgressIndicator(strokeWidth: 2);
                        },

                        errorBuilder: (context, exception, stackTrace) {
                          return const Icon(
                            Icons.broken_image,
                            color: AppColors.grey400,
                            size: AppIconSize.xl,
                          );
                        },
                      )
                    : const Icon(
                        Icons.image_outlined,
                        size: AppIconSize.xl,
                        color: AppColors.grey400,
                      ),
              ),
            ),

            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.space8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      projectPreviews.projectName,
                      style: const TextStyle(
                        fontSize: AppFontSize.md,
                        fontWeight: AppFontWeight.medium,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.space8),
                    Text(
                      projectPreviews.userName ?? '알 수 없음',
                      style: const TextStyle(fontSize: AppFontSize.sm, color: AppColors.grey400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
