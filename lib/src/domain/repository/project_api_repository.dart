import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/model/project_previews.dart';

abstract class ProjectApiRepository {
  Future<Result<List<Project>>> getProjects();
  Future<Result<Project>> putProject();
  Future<Result<Project>> postProject();
  // Future<Result<Project>> getProject();
  // Future<void> deleteProject();
  Future<Result<List<ProjectPreviews>>> getProjectPreviews();
  //Future<Result<Project>> getMyProject();
}