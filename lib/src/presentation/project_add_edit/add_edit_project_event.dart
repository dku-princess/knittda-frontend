import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/domain/model/project.dart';

part 'add_edit_project_event.freezed.dart';

@freezed
sealed class AddEditProjectEvent with _$AddEditProjectEvent {
  const factory AddEditProjectEvent.saveProject({
    required Project project,
    required XFile? file,
  }) = SaveProject;
}
