import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/default_thumbnail.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';

class GetDefaultThumbnailsUseCase {
  final ProjectApiRepository _repository;

  GetDefaultThumbnailsUseCase(this._repository);

  Future<Result<List<DefaultThumbnail>>> call() async {
    final result = await _repository.getDefaultThumbnails();

    return switch (result) {
      Success<List<DefaultThumbnail>>() => Result.success(result.data),
      Error<List<DefaultThumbnail>>() => Result.error(result.e),
    };
  }
}
