import 'dart:ui';
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
    final images = (workPreview.recentImageUrls ?? []).take(3).toList();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${workPreview.userName}  |  ${workPreview.projectName}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20
            ),

            if (images.isNotEmpty)
              LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = (constraints.maxWidth - 10 * 2) / 3;

                  return Row(
                    children: List.generate(images.length, (index) {
                      final isLast = index == images.length - 1;
                      final url = images[index];

                      return Padding(
                        padding: EdgeInsets.only(
                          right: index == images.length - 1 ? 0 : 10,
                        ),
                        child: SizedBox(
                          width: itemWidth,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.network(
                                  url,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  // 로딩 중 스피너
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                                  },
                                  // 실패 시 대체 UI
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade200,
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
                                    );
                                  },
                                ),
                                if (isLast)
                                  Positioned.fill(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 6,
                                            sigmaY: 6,
                                          ),
                                          child: Container(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        Text(
                                          '+ ${workPreview.recordNum}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}