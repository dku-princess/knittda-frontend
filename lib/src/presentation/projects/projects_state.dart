import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/project.dart';

part 'projects_state.freezed.dart';

@freezed
abstract class ProjectsState with _$ProjectsState {
  factory ProjectsState(
    List<Project> projects,
    bool isLoading,
    String? errorMessage,
  ) = _ProjectsState;
}
