import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/records.dart';

abstract class RecordApiRepository {
  Future<Result<List<Records>>> getRecords();
  Future<Result<Records>> putRecord({
    required Records record,
    required List<int>? deleteImageIds,
    required List<XFile>? files,
  });
  Future<Result<Records>> postRecord({
    required Records record,
    required List<XFile>? files,
  });
  Future<Result<Records>> getRecord({required int recordId});
  Future<Result<void>> deleteRecord({required int recordId});
  Future<Result<List<Records>>> getRecordsProjects({required int projectId});
}