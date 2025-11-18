import 'package:flutter_test/flutter_test.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project_previews.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/use_case/get_project_previews_use_case.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_event.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_view_model.dart';

void main() {
  test('vm이 잘 동작해야 한다', () async {
    final viewModel = ProjectPreviewsViewModel(GetProjectPreviewsUseCase(FakeProjectApiRepository()));

    await viewModel.onEvent(ProjectPreviewsEvent.loadProjectPreviews());

    final List<ProjectPreviews> result = fakeJson.map((e) => ProjectPreviews.fromJson(e)).toList();

    expect(viewModel.state.projectPreviews, result);
  });
}

class FakeProjectApiRepository extends ProjectApiRepository {
  @override
  Future<Result<List<ProjectPreviews>>> getProjectPreviews() async {
    Future.delayed(const Duration(milliseconds: 500));

    return Result.success(fakeJson.map((e) => ProjectPreviews.fromJson(e)).toList());
  }
}

List<Map<String, dynamic>> fakeJson = [];