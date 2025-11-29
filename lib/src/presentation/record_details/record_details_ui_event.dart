import 'package:freezed_annotation/freezed_annotation.dart';

part 'record_details_ui_event.freezed.dart';

@freezed
sealed class RecordDetailsUiEvent with _$RecordDetailsUiEvent {
  const factory RecordDetailsUiEvent.deletedRecord() = DeletedRecord;
  const factory RecordDetailsUiEvent.showSnackBar(String message) =
      ShowSnackBar;
}
