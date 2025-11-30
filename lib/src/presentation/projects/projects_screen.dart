import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';
import 'package:knittda/src/domain/use_case/add_project_use_case.dart';
import 'package:knittda/src/domain/use_case/delete_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_my_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_project_use_case.dart';
import 'package:knittda/src/domain/use_case/update_project_use_case.dart';
import 'package:knittda/src/domain/use_case_record/get_records_projects_use_case.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_screen.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_view_model.dart';
import 'package:knittda/src/presentation/project_details/project_details_screen.dart';
import 'package:knittda/src/presentation/project_details/project_details_view_model.dart';
import 'package:knittda/src/presentation/projects/components/projects_item.dart';
import 'package:knittda/src/presentation/projects/components/order_section.dart';
import 'package:knittda/src/presentation/projects/projects_event.dart';
import 'package:knittda/src/presentation/projects/projects_view_model.dart';
import 'package:provider/provider.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProjectsViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        centerTitle: false,
        scrolledUnderElevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            '나의\n뜨개 작품',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () async {
          final addProject = await Navigator.push<Project>(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => AddEditProjectViewModel(
                  AddProjectUseCase(context.read<ProjectApiRepository>()),
                  UpdateProjectUseCase(context.read<ProjectApiRepository>()),
                ),
                child: const AddEditProjectScreen(),
              ),
            ),
          );

          if (addProject != null) {
            viewModel.onEvent(const ProjectsEvent.loadProjects());
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: state.isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("작품 불러오는 중..."),
                  SizedBox(height: 24),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : state.errorMessage != null
          ? Center(child: Text(state.errorMessage!))
          : Column(
              children: [
                const SizedBox(height: 20),

                OrderSection(
                  projectOrder: state.projectOrder,
                  onOrderChanged: (projectOrder) {
                    viewModel.onEvent(ProjectsEvent.changeOrder(projectOrder));
                  },
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: state.projects.isEmpty
                      ? const Center(
                          child: Text(
                            '작품이 없습니다',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          itemBuilder: (context, index) {
                            return ProjectsItem(
                              project: state.projects[index],
                              onTap: () async {
                                bool? isDelete = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider(
                                          create: (context) =>
                                              ProjectDetailsViewModel(
                                                GetProjectUseCase(
                                                  context
                                                      .read<
                                                        ProjectApiRepository
                                                      >(),
                                                ),
                                                GetMyProjectUseCase(
                                                  context
                                                      .read<
                                                        ProjectApiRepository
                                                      >(),
                                                ),
                                                DeleteProjectUseCase(
                                                  context
                                                      .read<
                                                        ProjectApiRepository
                                                      >(),
                                                ),
                                                UpdateProjectUseCase(
                                                  context
                                                      .read<
                                                        ProjectApiRepository
                                                      >(),
                                                ),
                                                GetRecordsProjectsUseCase(
                                                  context
                                                      .read<
                                                        RecordApiRepository
                                                      >(),
                                                ),
                                                projectId:
                                                    state.projects[index].id!,
                                                project: state.projects[index],
                                              ),
                                          child: const ProjectDetailsScreen(),
                                        ),
                                  ),
                                );

                                if (isDelete != null && isDelete) {
                                  viewModel.onEvent(
                                    const ProjectsEvent.loadProjects(),
                                  );
                                }
                              },
                            );
                          },
                          itemCount: state.projects.length,
                        ),
                ),
              ],
            ),
    );
  }
}
