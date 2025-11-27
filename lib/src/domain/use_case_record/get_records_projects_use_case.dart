import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';

class GetRecordsProjectsUseCase {
  final RecordApiRepository _repository;

  GetRecordsProjectsUseCase(this._repository);

  Future<Result<List<Records>>> call({required int projectId}) async {
    final result = await _repository.getRecordsProjects(projectId: projectId);

    return switch (result) {
      // Success(:final data) => Result.success(data),
      // Error(:final e) => Result.error(e),
      Success<List<Records>>() => Result.success(result.data),
      Error<List<Records>>() => Result.error(result.e),
    };
  }
}
