import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/knittda_app_bar.dart';
import 'package:knittda/src/presentation/widgets/knittda_button.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';
import 'package:knittda/src/domain/repository/report_api_repository.dart';
import 'package:knittda/src/domain/use_case/add_project_use_case.dart';
import 'package:knittda/src/domain/use_case/delete_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_my_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_report_use_case.dart';
import 'package:knittda/src/domain/use_case/get_user_use_case.dart';
import 'package:knittda/src/domain/use_case/update_project_use_case.dart';
import 'package:knittda/src/domain/use_case/add_record_use_case.dart';
import 'package:knittda/src/domain/use_case/get_question_use_case.dart';
import 'package:knittda/src/domain/use_case/get_records_projects_use_case.dart';
import 'package:knittda/src/domain/use_case/update_record_use_case.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_screen.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_view_model.dart';
import 'package:knittda/src/presentation/project_details/project_details_screen.dart';
import 'package:knittda/src/presentation/project_details/project_details_view_model.dart';
import 'package:knittda/src/presentation/projects/components/projects_item.dart';
import 'package:knittda/src/presentation/projects/components/order_section.dart';
import 'package:knittda/src/presentation/projects/projects_event.dart';
import 'package:knittda/src/presentation/projects/projects_view_model.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_screen.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_view_model.dart';
import 'package:knittda/src/presentation/report/report_screen.dart';
import 'package:knittda/src/presentation/report/report_view_model.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/core/theme/theme.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProjectsViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: const KnittdaAppBar(
        title: '나의\n뜨개 작품',
        large: true,
        showBack: false,
        toolbarHeight: kToolbarHeight + 30,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () async {
          await Navigator.push<Project>(
            context,
            MaterialPageRoute(
              settings: const RouteSettings(name: 'project_add'),
              builder: (context) => ChangeNotifierProvider(
                create: (context) => AddEditProjectViewModel(
                  AddProjectUseCase(context.read<ProjectApiRepository>()),
                  UpdateProjectUseCase(context.read<ProjectApiRepository>()),
                ),
                child: const AddEditProjectScreen(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),

      body: state.isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("작품 불러오는 중..."),
                  SizedBox(height: AppSpacing.space24),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : state.errorMessage != null
          ? Center(child: Text(state.errorMessage!))
          : Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: AppSpacing.space32),

                    Padding(
                      padding: const EdgeInsets.only(
                        top: AppSpacing.space12,
                        bottom: 15,
                        left: AppSpacing.space32,
                        right: AppSpacing.space32,
                      ),
                      child: OrderSection(
                        projectOrder: state.projectOrder,
                        onOrderChanged: (projectOrder) {
                          viewModel.onEvent(
                            ProjectsEvent.changeOrder(projectOrder),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: AppSpacing.space20),

                    Expanded(
                      child: state.projects.isEmpty
                          ? const Center(
                              child: Text(
                                '작품이 없습니다',
                                style: TextStyle(
                                  fontSize: AppFontSize.lg,
                                  color: AppColors.grey400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.only(bottom: 80),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: AppSpacing.space12),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.space32,
                                  ),
                                  child: ProjectsItem(
                                    project: state.projects[index],
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          settings: const RouteSettings(name: 'project_detail'),
                                          builder: (context) => ChangeNotifierProvider(
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
                                                  context
                                                      .read<GetUserUseCase>(),
                                                  projectId:
                                                      state.projects[index].id!,
                                                  project:
                                                      state.projects[index],
                                                  source: 'project_list',
                                                ),
                                            child: const ProjectDetailsScreen(),
                                          ),
                                        ),
                                      );
                                    },

                                    onPressed: () async {
                                      final addRecord = await Navigator.push<Records>(
                                        context,
                                        MaterialPageRoute(
                                          settings: const RouteSettings(name: 'record_add'),
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                                create: (context) =>
                                                    AddEditRecordViewModel(
                                                      AddRecordUseCase(
                                                        context
                                                            .read<
                                                              RecordApiRepository
                                                            >(),
                                                      ),
                                                      UpdateRecordUseCase(
                                                        context
                                                            .read<
                                                              RecordApiRepository
                                                            >(),
                                                      ),
                                                      GetQuestionUseCase(
                                                        context
                                                            .read<
                                                              RecordApiRepository
                                                            >(),
                                                      ),
                                                      projectId: state
                                                          .projects[index]
                                                          .id!,
                                                    ),
                                                child: AddEditRecordScreen(
                                                  projectId:
                                                      state.projects[index].id!,
                                                ),
                                              ),
                                        ),
                                      );

                                      if (addRecord != null) {
                                        viewModel.onEvent(
                                          ProjectsEvent.loadProjects(),
                                        );
                                      }
                                    },
                                  ),
                                );
                              },
                              itemCount: state.projects.length,
                            ),
                    ),
                  ],
                ),

                if (DateTime.now().weekday == DateTime.tuesday)
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: KnittdaButton(
                      style: KnittdaButtonStyle.secondary,
                      label: '주간 리포트 확인',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            settings: const RouteSettings(name: 'report'),
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => ReportViewModel(
                                GetReportUseCase(
                                  context.read<ReportApiRepository>(),
                                ),
                              ),
                              child: ReportScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
    );
  }
}
