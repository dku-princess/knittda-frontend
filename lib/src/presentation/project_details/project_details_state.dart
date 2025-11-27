import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/project.dart';

part 'project_details_state.freezed.dart';

@freezed
abstract class ProjectDetailsState with _$ProjectDetailsState {
  factory ProjectDetailsState({
    required Project? project,
    required bool isLoading,
  }) = _ProjectDetailsState;
}
