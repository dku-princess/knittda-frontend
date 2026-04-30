import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/markdown_utils.dart';
import 'package:knittda/src/domain/model/article/qa_section.dart';
import 'package:knittda/src/presentation/article_detail/components/gellery_widge.dart';

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
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              qaSection.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
        ],

        if (qaSection.description != null &&
            qaSection.description!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: MarkdownBody(
              data: normalizeMarkdown(qaSection.description!),
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
          ),
        ],

        for (int i = 0; i < qaSection.qaItemBlock.length; i++) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //질문
                if (qaSection.qaItemBlock[i].question.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _QuestionBubble(
                      question: qaSection.qaItemBlock[i].question,
                    ),
                  ),

                //답변
                if (qaSection.qaItemBlock[i].answer.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: MarkdownBody(
                      data: normalizeMarkdown(qaSection.qaItemBlock[i].answer),
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),

                //이미지
                if (qaSection.qaItemBlock[i].image != null &&
                    qaSection.qaItemBlock[i].image!.isNotEmpty) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
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
          if (i < qaSection.qaItemBlock.length - 1) const SizedBox(height: 40),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: PRIMARY_COLOR, width: 1),
      ),
      child: Text(
        question,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}
