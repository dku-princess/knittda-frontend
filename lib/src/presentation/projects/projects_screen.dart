import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/use_case/add_project_use_case.dart';
import 'package:knittda/src/domain/use_case/update_project_use_case.dart';
import 'package:knittda/src/presentation/add_edit_project/add_edit_project_screen.dart';
import 'package:knittda/src/presentation/add_edit_project/add_edit_project_view_model.dart';
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
          bool? isSaved = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) => AddEditProjectViewModel(
                  AddProjectUseCase(context.read<ProjectApiRepository>()),
                  UpdateProjectUseCase(context.read<ProjectApiRepository>()),
                ),
                child: const AddEditProjectScreen(),
              ),
            ),
          );

          if (isSaved != null && isSaved) {
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
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                      top: 4,
                      bottom: 80,
                      left: 20,
                      right: 20,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: ProjectsItem(project: state.projects[index]),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.grey[300]),
                    itemCount: state.projects.length,
                  ),
                ),
              ],
            ),
    );
  }
}
