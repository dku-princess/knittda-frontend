import 'package:flutter/material.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';
import 'package:knittda/src/domain/use_case/delete_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_my_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_stored_user_use_case.dart';
import 'package:knittda/src/domain/use_case/update_project_use_case.dart';
import 'package:knittda/src/domain/use_case_record/get_records_projects_use_case.dart';
import 'package:knittda/src/presentation/project_details/project_details_screen.dart';
import 'package:knittda/src/presentation/project_details/project_details_view_model.dart';
import 'package:knittda/src/presentation/project_previews/components/project_previews_item.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_event.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_view_model.dart';
import 'package:provider/provider.dart';

class ProjectPreviewsScreen extends StatelessWidget {
  const ProjectPreviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            '작품',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      body: Consumer<ProjectPreviewsViewModel>(
        builder: (context, viewModel, _) {
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
            child: GridView.builder(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              itemCount: viewModel.state.projectPreviews.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final projectPreviews = viewModel.state.projectPreviews[index];
                return ProjectPreviewsItem(
                  projectPreviews: projectPreviews,
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
                            context.read<GetStoredUserUseCase>(),
                            projectId: projectPreviews.projectId,
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
              },
            ),
          );
        },
      ),
    );
  }
}
