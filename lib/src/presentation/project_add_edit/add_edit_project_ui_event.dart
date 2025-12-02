import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/project.dart';

part 'add_edit_project_ui_event.freezed.dart';

@freezed
sealed class AddEditProjectUiEvent with _$AddEditProjectUiEvent {
  const factory AddEditProjectUiEvent.savedProject(Project project) = SavedProject;
  const factory AddEditProjectUiEvent.showSnackBar(String message) = ShowSnackBar;
}
