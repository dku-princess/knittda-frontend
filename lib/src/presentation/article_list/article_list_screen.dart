import 'package:flutter/material.dart';
import 'package:knittda/src/domain/repository/article_repository.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/use_case/get_article_previews_use_case.dart';
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
        title: const Text(
          '뜨다 아티클',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        titleSpacing: 30,
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
                await viewModel.onEvent(ArticleListEvent.loadArticles());
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
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
            return RefreshIndicator(
              onRefresh: () async {
                await viewModel.onEvent(ArticleListEvent.loadArticles());
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const Center(child: Text('아티클이 없습니다.')),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await viewModel.onEvent(ArticleListEvent.loadArticles());
            },
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification &&
                    notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent - 200) {
                  viewModel.onEvent(ArticleListEvent.loadMore());
                }
                return false;
              },
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount:
                    state.articles.length + (state.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  // 마지막 아이템이면 로딩 인디케이터
                  if (index == state.articles.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final article = state.articles[index];

                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 0,
                        bottom: 40,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          final slugOrId = article.slug.trim().isEmpty
                              ? article.id.toString()
                              : article.slug;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                create: (context) => ArticleDetailViewModel(
                                  context.read<ArticleRepository>(),
                                  GetArticlePreviewsUseCase(
                                    context.read<ProjectApiRepository>(),
                                  ),
                                  slugOrId: slugOrId,
                                ),
                                child: const ArticleDetailScreen(),
                              ),
                            ),
                          );
                        },
                        child: ArticleCardLarge(
                          article: article,
                          imageUrl: article.thumbnailImageLarge.isNotEmpty
                              ? viewModel.getAssetUrl(
                                  article.thumbnailImageLarge,
                                )
                              : null,
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 0,
                      bottom: 24,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        final slugOrId = article.slug.trim().isEmpty
                            ? article.id.toString()
                            : article.slug;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => ArticleDetailViewModel(
                                context.read<ArticleRepository>(),
                                GetArticlePreviewsUseCase(
                                  context.read<ProjectApiRepository>(),
                                ),
                                slugOrId: slugOrId,
                              ),
                              child: const ArticleDetailScreen(),
                            ),
                          ),
                        );
                      },
                      child: ArticleCardSmall(
                        article: article,
                        imageUrl: article.thumbnailImageSmall.isNotEmpty
                            ? viewModel.getAssetUrl(article.thumbnailImageSmall)
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
