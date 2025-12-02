import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/util/project_order.dart';

part 'projects_state.freezed.dart';

@freezed
abstract class ProjectsState with _$ProjectsState {
  factory ProjectsState(
    List<Project> projects,
    bool isLoading,
    String? errorMessage,
    ProjectOrder projectOrder,
  ) = _ProjectsState;
}
