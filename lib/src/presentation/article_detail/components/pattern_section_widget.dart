import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:knittda/src/core/utils/markdown_utils.dart';
import 'package:knittda/src/domain/model/article/pattern_section.dart';
import 'package:knittda/src/presentation/article_detail/components/gellery_widge.dart';
import 'package:knittda/src/core/theme/theme.dart';

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
            padding: const EdgeInsets.only(bottom: AppSpacing.space20),
            child: Text(
              patternSection.title,
              style: const TextStyle(fontSize: AppFontSize.xl, fontWeight: AppFontWeight.semibold),
            ),
          ),
        ],

        if (patternSection.description != null &&
            patternSection.description!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space20),
            child: MarkdownBody(
              data: normalizeMarkdown(patternSection.description!),
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(fontSize: AppFontSize.md, color: AppColors.textSecondary),
              ),
            ),
          ),
        ],

        for (int i = 0; i < patternSection.patternItemBlock.length; i++) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),

            decoration: BoxDecoration(
              color: _PatternColors.background,
              borderRadius: BorderRadius.circular(AppRadius.button),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (patternSection.patternItemBlock[i].title.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.space12),
                    child: Text(
                      patternSection.patternItemBlock[i].title,
                      style: const TextStyle(
                        fontSize: AppFontSize.md,
                        fontWeight: AppFontWeight.semibold,
                        color: _PatternColors.accent,
                      ),
                    ),
                  ),
                ],

                if (patternSection
                    .patternItemBlock[i]
                    .description
                    .isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.space12),
                    child: MarkdownBody(
                      data: normalizeMarkdown(
                        patternSection.patternItemBlock[i].description,
                      ),
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(
                          fontSize: AppFontSize.md,
                          color: _PatternColors.body,
                        ),
                      ),
                    ),
                  ),
                ],

                if (patternSection.patternItemBlock[i].image != null &&
                    patternSection.patternItemBlock[i].image!.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.space12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.button),
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
                              color: AppColors.grey100,
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColors.grey400,
                                  size: AppIconSize.lg,
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
                    padding: const EdgeInsets.only(bottom: AppSpacing.space12),
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
                    padding: const EdgeInsets.only(bottom: AppSpacing.space12),
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
            const SizedBox(height: AppSpacing.space20),
        ],
      ],
    );
  }
}

/// 도안(pattern) 섹션 전용 로컬 색상.
/// 전역 디자인 토큰이 아니라 이 화면에서만 쓰는 warm 테마 색이라 여기에 둔다.
class _PatternColors {
  const _PatternColors._();

  static const Color background = Color(0xFFFDF7F2);
  static const Color accent = Color(0xFFCC7A3A); // 소제목
  static const Color body = Color(0xFF5C4A3D); // 본문
}
