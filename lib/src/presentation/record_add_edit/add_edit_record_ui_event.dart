import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/records.dart';

part 'add_edit_record_ui_event.freezed.dart';

@freezed
sealed class AddEditRecordUiEvent with _$AddEditRecordUiEvent {
  const factory AddEditRecordUiEvent.savedRecord(Records record) = SavedRecord;
  const factory AddEditRecordUiEvent.showSnackBar(String message) =
      ShowSnackBar;
}
