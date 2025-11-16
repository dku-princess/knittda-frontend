import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project_previews.dart';

abstract class ProjectApiRepository {
  Future<Result<List<ProjectPreviews>>> getProjectPreviews();
}