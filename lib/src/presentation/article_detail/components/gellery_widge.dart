import 'package:flutter/material.dart';
import 'package:knittda/src/domain/model/article/qa_section.dart';
import 'package:knittda/src/core/theme/theme.dart';

class GalleryWidget extends StatelessWidget {
  final List<GalleryItem> items;
  final String Function(String) getAssetUrl;

  const GalleryWidget({
    super.key,
    required this.items,
    required this.getAssetUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: AppSpacing.space8),
        itemBuilder: (context, index) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.77,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.button),
              child: Image.network(
                getAssetUrl(items[index].directusFilesId),
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  width: 160,
                  color: AppColors.grey100,
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.grey400,
                      size: AppIconSize.base,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
