import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/domain/model/article/qa_section.dart';
import 'package:knittda/src/presentation/article_detail/article_detail_view_model.dart';
import 'package:knittda/src/presentation/article_detail/components/qa_section_widget.dart';
import 'package:provider/provider.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0),

      body: Consumer<ArticleDetailViewModel>(
        builder: (context, viewModel, _) {
          final state = viewModel.state;

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }

          final article = state.article;
          if (article == null) {
            return Center(child: Text('아티클을 찾을 수 없습니다.'));
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 50, right: 20, left: 20),
            child: ListView.builder(
              itemCount: article.sections.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF7ECDC0).withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          article.category,
                          style: const TextStyle(fontSize: 12, color: PRIMARY_COLOR),
                        ),
                      ),

                      SizedBox(height: 16),

                      Text(
                        article.title,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                      ),

                      SizedBox(height: 16),

                      Text(
                        article.subtitle,
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),

                      SizedBox(height: 16),

                      Row(
                        children: [
                          Text(
                            article.interviewee,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          SizedBox(width: 12),
                          Text(
                            article.publishedAt,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                    ],
                  );
                }
                final section = article.sections[index - 1];
                switch (section.collection) {
                  case 'qa_section':
                    final qaSection = QaSection.fromJson(section.item!);
                    return QaSectionWidget(
                      qaSection: qaSection,
                      getAssetUrl: viewModel.getAssetUrl,
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
