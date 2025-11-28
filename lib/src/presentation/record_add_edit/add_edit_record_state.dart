import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/presentation/record_add_edit/question_state.dart';

part 'add_edit_record_state.freezed.dart';

@freezed
abstract class AddEditRecordState with _$AddEditRecordState {
  factory AddEditRecordState({
    required bool isLoading,
    required QuestionState questionState,
  }) = _AddEditRecordState;
}
