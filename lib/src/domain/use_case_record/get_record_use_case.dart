import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';

class GetRecordUseCase {
  final RecordApiRepository _repository;

  GetRecordUseCase(this._repository);

  Future<Result<Records>> call({
    required int recordId
  }) async {
    final result = await _repository.getRecord(recordId: recordId);

    return switch (result) {
    // Success(:final data) => Result.success(data),
    // Error(:final e) => Result.error(e),
      Success<Records>() => Result.success(result.data),
      Error<Records>() => Result.error(result.e),
    };
  }

}