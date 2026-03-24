import 'package:flutter/material.dart';
import 'package:knittda/src/domain/repository/article_repository.dart';
import 'package:knittda/src/presentation/article_detail/article_detail_screen.dart';
import 'package:knittda/src/presentation/article_detail/article_detail_view_model.dart';
import 'package:knittda/src/presentation/article_list/article_list_event.dart';
import 'package:knittda/src/presentation/article_list/article_list_view_model.dart';
import 'package:knittda/src/presentation/article_list/components/article_card_large.dart';
import 'package:knittda/src/presentation/article_list/components/article_card_small.dart';
import 'package:provider/provider.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            '뜨다 아티클',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      body: Consumer<ArticleListViewModel>(
        builder: (context, viewModel, _) {
          final state = viewModel.state;

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return RefreshIndicator(
              onRefresh: () async {
                await viewModel.onEvent(ArticleListEvent.fetchArticles());
              },
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(child: Text(state.errorMessage!)),
                  ),
                ],
              ),
            );
          }

          if (state.articles.isEmpty) {
            return const Center(child: Text('아티클이 없습니다.'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await viewModel.onEvent(ArticleListEvent.fetchArticles());
            },
            child: ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final article = state.articles[index];

                if (article.isFeatured) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => ArticleDetailViewModel(
                              context.read<ArticleRepository>(),
                              slugOrId: article.slug,
                            ),
                            child: const ArticleDetailScreen(),
                          ),
                        ),
                      );
                    },
                    child: ArticleCardLarge(
                      article: article,
                      // imageUrl: viewModel.getAssetUrl(
                      //   article.thumbnailImageLarge,
                      // ),
                    ),
                  );
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => ArticleDetailViewModel(
                            context.read<ArticleRepository>(),
                            slugOrId: article.slug,
                          ),
                          child: const ArticleDetailScreen(),
                        ),
                      ),
                    );
                  },
                  child: ArticleCardSmall(
                    article: article,
                    index: index,
                    //imageUrl: viewModel.getAssetUrl(article.thumbnailImageSmall),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
