import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/domain/model/article/qa_section.dart';

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
        Text(
          qaSection.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        if (qaSection.description != null) ...[
          SizedBox(height: 12),
          Text(
            qaSection.description!,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
        SizedBox(height: 20),
        for (int i = 0; i < qaSection.qaItemBlock.length; i++) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //질문
                _QuestionBubble(question: qaSection.qaItemBlock[i].question),

                SizedBox(height: 16),

                //답변
                Text('A. ${qaSection.qaItemBlock[i].answer}', style: TextStyle(fontSize: 14)),

                //이미지
                if (qaSection.qaItemBlock[i].image != null) ...[
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      getAssetUrl(qaSection.qaItemBlock[i].image!),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.shrink(),
                    ),
                  ),
                ],

                // 갤러리
                if (qaSection.qaItemBlock[i].gallery.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: qaSection.qaItemBlock[i].gallery.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final item = qaSection.qaItemBlock[i].gallery[index];
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                getAssetUrl(item.directusFilesId),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const SizedBox.shrink(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         for (int j = 0; j < qaSection.qaItemBlock[i].gallery.length; j++)
                            Container(
                              width: 6,
                              height: 6,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[400],
                              ),
                            ),
                        ],
                      ),
                    ],
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
