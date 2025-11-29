import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/records.dart';

part 'record_details_state.freezed.dart';

@freezed
abstract class RecordDetailsState with _$RecordDetailsState {
  factory RecordDetailsState({
    required Records? record,
    required bool isLoading,
  }) = _RecordDetailsState;
}
