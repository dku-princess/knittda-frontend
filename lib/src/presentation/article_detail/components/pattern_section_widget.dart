import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:knittda/src/core/utils/markdown_utils.dart';
import 'package:knittda/src/domain/model/article/pattern_section.dart';
import 'package:knittda/src/presentation/article_detail/components/gellery_widge.dart';

class PatternSectionWidget extends StatelessWidget {
  final PatternSection patternSection;
  final String Function(String) getAssetUrl;

  const PatternSectionWidget({
    super.key,
    required this.patternSection,
    required this.getAssetUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (patternSection.title.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              patternSection.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
        ],

        if (patternSection.description != null &&
            patternSection.description!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: MarkdownBody(
              data: normalizeMarkdown(patternSection.description!),
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
          ),
        ],

        for (int i = 0; i < patternSection.patternItemBlock.length; i++) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),

            decoration: BoxDecoration(
              color: Color(0xFFFDF7F2),
              borderRadius: BorderRadius.circular(8),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (patternSection.patternItemBlock[i].title.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      patternSection.patternItemBlock[i].title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFCC7A3A),
                      ),
                    ),
                  ),
                ],

                if (patternSection
                    .patternItemBlock[i]
                    .description
                    .isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: MarkdownBody(
                      data: normalizeMarkdown(
                        patternSection.patternItemBlock[i].description,
                      ),
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5C4A3D),
                        ),
                      ),
                    ),
                  ),
                ],

                if (patternSection.patternItemBlock[i].image != null &&
                    patternSection.patternItemBlock[i].image!.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AspectRatio(
                        aspectRatio:
                            patternSection.patternItemBlock[i].imageRatio ==
                                'portrait_3_4'
                            ? 3 / 4
                            : 4 / 3,
                        child: Image.network(
                          getAssetUrl(
                            patternSection.patternItemBlock[i].image!,
                          ),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey,
                                  size: 32,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],

                if (patternSection.patternItemBlock[i].gallery.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GalleryWidget(
                      items: patternSection.patternItemBlock[i].gallery,
                      getAssetUrl: getAssetUrl,
                    ),
                  ),
                ],

                if (patternSection
                    .patternItemBlock[i]
                    .gallerySecond
                    .isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GalleryWidget(
                      items: patternSection.patternItemBlock[i].gallerySecond,
                      getAssetUrl: getAssetUrl,
                    ),
                  ),
                ],
              ],
            ),
          ),

          if (i < patternSection.patternItemBlock.length - 1)
            const SizedBox(height: 20),
        ],
      ],
    );
  }
}
