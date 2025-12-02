import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';

class AddRecordUseCase {
  final RecordApiRepository _repository;

  AddRecordUseCase(this._repository);

  Future<Result<Records>> call({
    required Records record,
    required List<XFile>? files,
  }) async {
    final result = await _repository.postRecord(record: record, files: files);

    return switch (result) {
      // Success(:final data) => Result.success(data),
      // Error(:final e) => Result.error(e),
      Success<Records>() => Result.success(result.data),
      Error<Records>() => Result.error(result.e),
    };
  }
}
