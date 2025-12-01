import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';

class DeleteRecordUseCase {
  final RecordApiRepository _repository;

  DeleteRecordUseCase(this._repository);

  Future<Result<void>> call({required int recordId}) async {
    final result = await _repository.deleteRecord(recordId: recordId);

    return switch (result) {
    // Success(:final data) => Result.success(data),
    // Error(:final e) => Result.error(e),
      Success<void>() => Result.success(null),
      Error<void>() => Result.error(result.e),
    };
  }
}