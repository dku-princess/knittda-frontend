import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_details_ui_event.freezed.dart';

@freezed
sealed class ProjectDetailsUiEvent with _$ProjectDetailsUiEvent {
  const factory ProjectDetailsUiEvent.deletedProject() = DeletedProject;
  const factory ProjectDetailsUiEvent.showSnackBar(String message) = ShowSnackBar;
}
