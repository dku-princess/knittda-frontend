import 'package:flutter/material.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';
import 'package:knittda/src/domain/use_case/delete_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_my_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_user_use_case.dart';
import 'package:knittda/src/domain/use_case/update_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_records_projects_use_case.dart';
import 'package:knittda/src/performance/initial_load_tracker.dart';
import 'package:knittda/src/presentation/project_details/project_details_screen.dart';
import 'package:knittda/src/presentation/project_details/project_details_view_model.dart';
import 'package:knittda/src/presentation/project_previews/components/project_previews_item.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_event.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_view_model.dart';
import 'package:provider/provider.dart';

class ProjectPreviewsScreen extends StatefulWidget {
  const ProjectPreviewsScreen({super.key});

  @override
  State<ProjectPreviewsScreen> createState() => _ProjectPreviewsScreenState();
}

class _ProjectPreviewsScreenState extends State<ProjectPreviewsScreen> {
  bool _initialLoadT4Scheduled = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 300) {
      context.read<ProjectPreviewsViewModel>().onEvent(
        const ProjectPreviewsEvent.loadMore(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0,
        title: const Text(
          '작품',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        titleSpacing: 30,
      ),

      body: Consumer<ProjectPreviewsViewModel>(
        builder: (context, viewModel, _) {
          final usable = !viewModel.state.isLoading &&
              viewModel.state.errorMessage == null;

          if (usable && !_initialLoadT4Scheduled) {
            _initialLoadT4Scheduled = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              InitialLoadTracker.projectPreviews.markT4();
            });
          }

          if (viewModel.state.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("작품 불러오는 중..."),
                  SizedBox(height: 24),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }

          if (viewModel.state.errorMessage != null) {
            return RefreshIndicator(
              onRefresh: () async {
                await viewModel.onEvent(
                  ProjectPreviewsEvent.loadProjectPreviews(),
                );
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [Center(child: Text(viewModel.state.errorMessage!))],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await viewModel.onEvent(
                ProjectPreviewsEvent.loadProjectPreviews(),
              );
            },
            child: CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.9,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildItem(context, viewModel, index),
                      childCount: viewModel.state.projectPreviews.length,
                    ),
                  ),
                ),
                if (viewModel.state.isLoadingMore)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    ProjectPreviewsViewModel viewModel,
    int index,
  ) {
    final projectPreviews = viewModel.state.projectPreviews[index];
    return ProjectPreviewsItem(
                  projectPreviews: projectPreviews,
                  onTap: () async {
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
                            projectId: projectPreviews.projectId,
                            source: 'project_previews',
                          ),
                          child: const ProjectDetailsScreen(),
                        ),
                      ),
                    );

                    if (deleted != null && deleted) {
                      viewModel.onEvent(
                        ProjectPreviewsEvent.loadProjectPreviews(),
                      );
                    }
                  },
                );
  }
}
