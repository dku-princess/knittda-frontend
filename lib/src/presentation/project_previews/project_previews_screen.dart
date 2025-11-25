import 'package:flutter/material.dart';
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
                return GestureDetector(
                  onTap: () {

                  },
                  child: ProjectPreviewsItem(projectPreviews: projectPreviews),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
