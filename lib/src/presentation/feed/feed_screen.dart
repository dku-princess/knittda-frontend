import 'package:flutter/material.dart';
import 'package:knittda/src/domain/repository/feed_api_repository.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';
import 'package:knittda/src/domain/use_case/delete_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_my_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_search_feed_use_case.dart';
import 'package:knittda/src/domain/use_case/get_user_use_case.dart';
import 'package:knittda/src/domain/use_case/update_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_records_projects_use_case.dart';
import 'package:knittda/src/presentation/feed/components/feed_item.dart';
import 'package:knittda/src/performance/initial_load_tracker.dart';
import 'package:knittda/src/presentation/feed/feed_event.dart';
import 'package:knittda/src/presentation/feed/feed_view_model.dart';
import 'package:knittda/src/presentation/feed_search/feed_search_screen.dart';
import 'package:knittda/src/presentation/feed_search/feed_search_view_model.dart';
import 'package:knittda/src/presentation/project_details/project_details_screen.dart';
import 'package:knittda/src/presentation/project_details/project_details_view_model.dart';
import 'package:knittda/src/presentation/widgets/image_viewer.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _initialLoadT4Scheduled = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final viewModel = context.read<FeedViewModel>();

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        if (viewModel.state.hasMore && !viewModel.state.isLoadingMore) {
          viewModel.onEvent(const FeedEvent.loadNext(20, null));
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0,
        title: const Text(
          '피드',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        titleSpacing: 30,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) {
                      final repository = context.read<FeedApiRepository>();
                      return FeedSearchViewModel(
                        GetSearchFeedUseCase(repository),
                        repository,
                      );
                    },
                    child: const FeedSearchScreen(),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),

      body: Consumer<FeedViewModel>(
        builder: (context, viewModel, _) {
          final s = viewModel.state;
          final usable =
              !(s.isLoading && s.feeds.isEmpty) &&
              !(s.errorMessage != null && s.feeds.isEmpty);

          if (usable && !_initialLoadT4Scheduled) {
            _initialLoadT4Scheduled = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              InitialLoadTracker.feed.markT4();
            });
          }

          if (viewModel.state.isLoading && viewModel.state.feeds.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("피드 불러오는 중..."),
                  SizedBox(height: 24),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }

          if (viewModel.state.errorMessage != null &&
              viewModel.state.feeds.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await viewModel.onEvent(FeedEvent.refresh(20, null));
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [Center(child: Text(viewModel.state.errorMessage!))],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await viewModel.onEvent(FeedEvent.refresh(20, null));
            },
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (viewModel.state.isLoadingMore &&
                    index == viewModel.state.feeds.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return FeedItem(
                  feed: viewModel.state.feeds[index],
                  onTap: () async {
                    final deleted = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => ProjectDetailsViewModel(
                            GetProjectUseCase(
                              context.read<ProjectApiRepository>(),
                            ),
                            GetMyProjectUseCase(
                              context.read<ProjectApiRepository>(),
                            ),
                            DeleteProjectUseCase(
                              context.read<ProjectApiRepository>(),
                            ),
                            UpdateProjectUseCase(
                              context.read<ProjectApiRepository>(),
                            ),
                            GetRecordsProjectsUseCase(
                              context.read<RecordApiRepository>(),
                            ),
                            context.read<GetUserUseCase>(),
                            projectId: viewModel.state.feeds[index].projectId,
                          ),
                          child: const ProjectDetailsScreen(),
                        ),
                      ),
                    );

                    if (deleted != null && deleted) {
                      viewModel.onEvent(FeedEvent.refresh(20, null));
                    }
                  },
                  onImageTap: (imageIndex, images) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ImageViewer(
                          images: images,
                          initialIndex: imageIndex,
                        ),
                      ),
                    );
                  },
                );
              },
              itemCount:
                  viewModel.state.feeds.length +
                  (viewModel.state.isLoadingMore ? 1 : 0),
            ),
          );
        },
      ),
    );
  }
}
