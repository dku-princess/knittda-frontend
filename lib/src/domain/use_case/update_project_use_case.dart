import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';

class UpdateProjectUseCase {
  final ProjectApiRepository _repository;

  UpdateProjectUseCase(this._repository);

  Future<Result<Project>> call({required Project project, required XFile? file}) async {
    final result = await _repository.putProject(project: project, file: file);

    return switch (result) {
      // Success(:final data) => Result.success(data),
      // Error(:final e) => Result.error(e),
      Success<Project>() => Result.success(result.data),
      Error<Project>() => Result.error(result.e),
    };
  }
}
