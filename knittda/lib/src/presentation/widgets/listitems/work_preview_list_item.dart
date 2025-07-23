import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/work_preview_model.dart';

class WorkPreviewListItem extends StatelessWidget {
  final WorkPreviewModel workPreview;
  final VoidCallback onTap;

  const WorkPreviewListItem({
    super.key,
    required this.workPreview,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = (workPreview.recentImageUrls?.isNotEmpty ?? false)
        ? workPreview.recentImageUrls!.first
        : null;

    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.black26,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목
              Text(
                workPreview.projectName,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 2),

              // 작성자
              Text(
                workPreview.userName,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 14),

              // 썸네일
              Expanded(
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: imageUrl != null
                          ? Image.network(
                        imageUrl,
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
                      )
                          : Container(
                        color: Colors.grey.shade300,
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}