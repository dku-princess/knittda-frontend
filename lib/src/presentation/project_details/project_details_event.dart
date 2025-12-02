import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/project.dart';

part 'project_details_event.freezed.dart';

@freezed
sealed class ProjectDetailsEvent with _$ProjectDetailsEvent {
  const factory ProjectDetailsEvent.loadProject({required int projectId, Project? project}) = LoadProject;
  const factory ProjectDetailsEvent.deleteProject({required int projectId}) =
      DeleteProject;
  const factory ProjectDetailsEvent.changeProgress() = ChangeProgress;
  const factory ProjectDetailsEvent.loadRecords({required int projectId}) = LoadRecords;
}
