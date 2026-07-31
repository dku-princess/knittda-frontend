import 'package:flutter/material.dart';
import 'package:knittda/src/domain/model/article/article_preview.dart';

class ArticlePreviewItem extends StatelessWidget {
  final ArticlePreview articlePreview;
  final VoidCallback onTap;

  const ArticlePreviewItem({
    super.key,
    required this.articlePreview,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = articlePreview.thumbnailUrl;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      elevation: 7,
      shadowColor: Colors.black38,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: hasImage
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
                            color: Colors.grey,
                            size: 40,
                          );
                        },
                      )
                    : Image.asset(
                        'assets/image/default_1.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
              ),
            ),

            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      articlePreview.projectName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      articlePreview.nickname ?? '알 수 없음',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
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
