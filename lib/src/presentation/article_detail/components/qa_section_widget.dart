import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/markdown_utils.dart';
import 'package:knittda/src/domain/model/article/qa_section.dart';
import 'package:knittda/src/presentation/article_detail/components/gellery_widge.dart';
import 'package:knittda/src/core/theme/theme.dart';

class QaSectionWidget extends StatelessWidget {
  final QaSection qaSection;
  final String Function(String) getAssetUrl;

  const QaSectionWidget({
    super.key,
    required this.qaSection,
    required this.getAssetUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (qaSection.title.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space20),
            child: Text(
              qaSection.title,
              style: TextStyle(fontSize: AppFontSize.xl, fontWeight: AppFontWeight.semibold),
            ),
          ),
        ],

        if (qaSection.description != null &&
            qaSection.description!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space20),
            child: MarkdownBody(
              data: normalizeMarkdown(qaSection.description!),
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(fontSize: AppFontSize.md, color: AppColors.textSecondary),
              ),
            ),
          ),
        ],

        for (int i = 0; i < qaSection.qaItemBlock.length; i++) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //질문
                if (qaSection.qaItemBlock[i].question.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.space16),
                    child: _QuestionBubble(
                      question: qaSection.qaItemBlock[i].question,
                    ),
                  ),

                //답변
                if (qaSection.qaItemBlock[i].answer.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.space16),
                    child: MarkdownBody(
                      data: normalizeMarkdown(qaSection.qaItemBlock[i].answer),
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(fontSize: AppFontSize.md),
                      ),
                    ),
                  ),

                //이미지
                if (qaSection.qaItemBlock[i].image != null &&
                    qaSection.qaItemBlock[i].image!.isNotEmpty) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.button),
                    child: AspectRatio(
                      aspectRatio:
                          qaSection.qaItemBlock[i].imageRatio == 'portrait_3_4'
                          ? 3 / 4
                          : 4 / 3,
                      child: Image.network(
                        getAssetUrl(qaSection.qaItemBlock[i].image!),
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
                ],

                // 갤러리
                if (qaSection.qaItemBlock[i].gallery.isNotEmpty) ...[
                  GalleryWidget(
                    items: qaSection.qaItemBlock[i].gallery,
                    getAssetUrl: getAssetUrl,
                  ),
                ],
              ],
            ),
          ),
          if (i < qaSection.qaItemBlock.length - 1) const SizedBox(height: AppSpacing.space40),
        ],
      ],
    );
  }
}

class _QuestionBubble extends StatelessWidget {
  final String question;

  const _QuestionBubble({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space8, vertical: AppSpacing.space8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: PRIMARY_COLOR, width: 1),
      ),
      child: Text(
        question,
        style: const TextStyle(
          fontSize: AppFontSize.lg,
          fontWeight: AppFontWeight.semibold,
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}
