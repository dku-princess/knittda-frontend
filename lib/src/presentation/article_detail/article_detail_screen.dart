import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/domain/model/article/note_section.dart';
import 'package:knittda/src/domain/model/article/purchase_link_section.dart';
import 'package:knittda/src/domain/model/article/qa_section.dart';
import 'package:knittda/src/domain/repository/article_repository.dart';
import 'package:knittda/src/presentation/article_detail/article_detail_view_model.dart';
import 'package:knittda/src/presentation/article_detail/components/note_section_widget.dart';
import 'package:knittda/src/presentation/article_detail/components/purchase_link_section_widget.dart';
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

          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 50, right: 20, left: 20),
            separatorBuilder: (context, index) {
              if (index == 0) {
                return const SizedBox(height: 20);
              }
              return const SizedBox(height: 50);
            },
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
                        style: const TextStyle(
                          fontSize: 12,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    Text(
                      article.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
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
                case 'purchase_link_section':
                  final purchaseLinkSection = PurchaseLinkSection.fromJson(
                    section.item!,
                  );
                  return PurchaseLinkSectionWidget(
                    purchaseLinkSection: purchaseLinkSection,
                  );
                case 'note_section':
                  final noteSection = NoteSection.fromJson(section.item!);
                  return NoteSectionWidget(
                    noteSection: noteSection,
                    onArticleTap: (slugOrId) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                            create: (_) => ArticleDetailViewModel(
                              context.read<ArticleRepository>(),
                              slugOrId: slugOrId
                            ),
                            child: const ArticleDetailScreen(),
                          ),
                        ),
                      );
                    },
                  );
                default:
                  return const SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }
}
