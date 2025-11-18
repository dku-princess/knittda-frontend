import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project_previews.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';

class GetProjectPreviewsUseCase {
  final ProjectApiRepository _repository;

  GetProjectPreviewsUseCase(this._repository);

  Future<Result<List<ProjectPreviews>>> call() async {
    final result = await _repository.getProjectPreviews();

    return switch (result) {
      //Success(:final data) => Result.success(data),
      //Error(:final e) => Result.error(e),
      Success<List<ProjectPreviews>>() => Result.success(result.data),
      Error<List<ProjectPreviews>>() => Result.error(result.e),
    };
  }
}
