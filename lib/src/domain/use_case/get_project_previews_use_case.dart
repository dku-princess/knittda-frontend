import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project_previews_page.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';

class GetProjectPreviewsUseCase {
  final ProjectApiRepository _repository;

  GetProjectPreviewsUseCase(this._repository);

  Future<Result<ProjectPreviewsPage>> call({
    int page = 0,
    int size = 50,
  }) async {
    final result = await _repository.getProjectPreviews(
      page: page,
      size: size,
    );

    return switch (result) {
      Success<ProjectPreviewsPage>() => Result.success(result.data),
      Error<ProjectPreviewsPage>() => Result.error(result.e),
    };
  }
}
