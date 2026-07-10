import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';
import 'package:knittda/src/domain/use_case/delete_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_my_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_user_use_case.dart';
import 'package:knittda/src/domain/use_case/update_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_records_projects_use_case.dart';
import 'package:knittda/src/presentation/feed/components/feed_item.dart';
import 'package:knittda/src/presentation/feed_search/feed_search_event.dart';
import 'package:knittda/src/presentation/feed_search/feed_search_ui_event.dart';
import 'package:knittda/src/presentation/feed_search/feed_search_view_model.dart';
import 'package:knittda/src/presentation/project_details/project_details_screen.dart';
import 'package:knittda/src/presentation/project_details/project_details_view_model.dart';
import 'package:knittda/src/presentation/widgets/image_viewer.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/core/theme/theme.dart';

class FeedSearchScreen extends StatefulWidget {
  const FeedSearchScreen({super.key});

  @override
  State<FeedSearchScreen> createState() => _FeedSearchScreenState();
}

class _FeedSearchScreenState extends State<FeedSearchScreen> {
  final _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    final viewModel = context.read<FeedSearchViewModel>();
    _controller.text = viewModel.state.keyword;

    _scrollController.addListener(() {
      final viewModel = context.read<FeedSearchViewModel>();

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        // 검색어가 있을 때만 동작
        if (viewModel.state.keyword.isNotEmpty &&
            viewModel.state.hasMore &&
            !viewModel.state.isLoadingMore) {
          viewModel.onEvent(FeedSearchEvent.loadNext(20, null));
        }
      }
    });

    Future.microtask(() {
      if (mounted) {
        final viewModel = context.read<FeedSearchViewModel>();

        _subscription = viewModel.eventStream.listen((event) {
          switch (event) {
            case ShowSnackBar(:final message):
              if (mounted) {
                final snackBar = SnackBar(content: Text(message));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  void _onSearch() {
    final keyword = _controller.text.trim();
    final viewModel = context.read<FeedSearchViewModel>();
    viewModel.onEvent(FeedSearchEvent.searchFeed(keyword, 0, 20, null));
  }

  void _onClear() {
    _controller.clear();
    final viewModel = context.read<FeedSearchViewModel>();
    viewModel.onEvent(const FeedSearchEvent.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: TextField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _onSearch(),
          decoration: InputDecoration(
            hintText: '검색',
            filled: true,
            fillColor: AppColors.grey100,
            contentPadding: EdgeInsets.symmetric(vertical: AppSpacing.space0, horizontal: AppSpacing.space8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.button),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              onPressed: _onClear,
              icon: Icon(Icons.close),
            ),
          ),
        ),
      ),

      body: Consumer<FeedSearchViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.state.isLoading && viewModel.state.feeds.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("검색 하는 중..."),
                  SizedBox(height: AppSpacing.space24),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }

          if (viewModel.state.feeds.isEmpty) {
            if (viewModel.state.keyword.isEmpty) {
              return const Center(child: Text('검색어를 입력해주세요'));
            }

            return Center(
              child: Text(
                '"${viewModel.state.keyword}" 에 대한 결과가 없습니다.',
                style: TextStyle(color: AppColors.grey400),
              ),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (viewModel.state.isLoadingMore &&
                  index == viewModel.state.feeds.length) {
                return const Padding(
                  padding: EdgeInsets.all(AppSpacing.space16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final feed = viewModel.state.feeds[index];
              final rank = viewModel.calculateRank(index);
              final recordId = feed.record.id ?? feed.record.recordId ?? 0;

              return FeedItem(
                feed: feed,
                onTap: () async {
                  // 클릭 로그 전송 (fire-and-forget)
                  if (recordId > 0) {
                    viewModel.sendClickLog(recordId: recordId, rank: rank);
                  }

                  final deleted = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      settings: const RouteSettings(name: 'project_detail'),
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
                          projectId: feed.projectId,
                          source: 'feed_search',
                        ),
                        child: const ProjectDetailsScreen(),
                      ),
                    ),
                  );

                  if (deleted != null && deleted) {
                    _onSearch();
                  }
                },
                onImageTap: (imageIndex, images) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ImageViewer(images: images, initialIndex: imageIndex),
                    ),
                  );
                },
              );
            },
            itemCount:
                viewModel.state.feeds.length +
                (viewModel.state.isLoadingMore ? 1 : 0),
          );
        },
      ),
    );
  }
}
