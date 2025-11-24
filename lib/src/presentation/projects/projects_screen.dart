import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/projects/components/projects_item.dart';
import 'package:knittda/src/presentation/projects/projects_view_model.dart';
import 'package:provider/provider.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          '나의 뜨개 작품',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),

      body: Consumer<ProjectsViewModel>(
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
            return Center(child: Text(viewModel.state.errorMessage!));
          }

          return Column(

            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(
                    top: 4,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: ProjectsItem(
                        project: viewModel.state.projects[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.grey[300]),
                  itemCount: viewModel.state.projects.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
