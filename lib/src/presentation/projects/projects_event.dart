import 'package:freezed_annotation/freezed_annotation.dart';

part 'projects_event.freezed.dart';

@freezed
sealed class ProjectsEvent with _$ProjectsEvent {
  const factory ProjectsEvent.loadProjects() = LoadProjects;
}
