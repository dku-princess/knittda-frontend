import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/model/project_previews.dart';

abstract class ProjectApiRepository {
  Future<Result<List<Project>>> getProjects();
  Future<Result<Project>> putProject({required Project project, required XFile? file});
  Future<Result<Project>> postProject({required Project project, required XFile? file});
  Future<Result<Project>> getProject({required int projectId});
  Future<Result<void>> deleteProject({required int projectId});
  Future<Result<List<ProjectPreviews>>> getProjectPreviews();
  Future<Result<Project>> getMyProject({required int projectId});
}