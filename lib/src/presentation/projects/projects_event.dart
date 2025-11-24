import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/util/project_order.dart';

part 'projects_event.freezed.dart';

@freezed
sealed class ProjectsEvent with _$ProjectsEvent {
  const factory ProjectsEvent.loadProjects() = LoadProjects;
  const factory ProjectsEvent.changeOrder(ProjectOrder projectOrder) = ChangeOrder;
}
