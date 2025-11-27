import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/record_api.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:knittda/src/domain/repository/record_api_repository.dart';

class RecordApiRepositoryImpl implements RecordApiRepository {
  final RecordApi _api;

  RecordApiRepositoryImpl(this._api);

  @override
  Future<Result<void>> deleteRecord({required int recordId}) async {
    final Result<void> result = await _api.deleteRecord(recordId: recordId);

    return switch (result) {
      Success() => Result.success(null),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<Result<Records>> getRecord({required int recordId}) async {
    final Result<Map<String, dynamic>> result = await _api.getRecord(
      recordId: recordId,
    );

    return switch (result) {
      Success(:final data) => Result.success(Records.fromJson(data)),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<Result<List<Records>>> getRecords() async {
    final Result<Iterable> result = await _api.getRecords();

    return switch (result) {
      Success(:final data) => Result.success(
        data.map((e) => Records.fromJson(e)).toList(),
      ),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<Result<List<Records>>> getRecordsProjects({
    required int projectId,
  }) async {
    final Result<Iterable> result = await _api.getRecordsProjects(
      projectId: projectId,
    );

    return switch (result) {
      Success(:final data) => Result.success(
        data.map((e) => Records.fromJson(e)).toList(),
      ),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<Result<Records>> postRecord({
    required Records record,
    required List<XFile>? files,
  }) async {
    final Result<Map<String, dynamic>> result = await _api.postRecord(
      record: record,
      files: files,
    );

    return switch (result) {
      Success(:final data) => Result.success(Records.fromJson(data)),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<Result<Records>> putRecord({
    required Records record,
    required List<int>? deleteImageIds,
    required List<XFile>? files,
  }) async {
    final Result<Map<String, dynamic>> result = await _api.putRecord(
      record: record,
      deleteImageIds: deleteImageIds,
      files: files,
    );

    return switch (result) {
      Success(:final data) => Result.success(Records.fromJson(data)),
      Error(:final e) => Result.error(e),
    };
  }
}
