import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/records.dart';

part 'record_details_event.freezed.dart';

@freezed
sealed class RecordDetailsEvent with _$RecordDetailsEvent {
  const factory RecordDetailsEvent.loadRecord({
    required int recordId,
    required Records record,
  }) = LoadRecord;

  const factory RecordDetailsEvent.deleteRecord({required int recordId}) =
      DeleteRecord;

  const factory RecordDetailsEvent.markChanged() = MarkChanged;
}
