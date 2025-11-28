import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_state.freezed.dart';

@freezed
abstract class QuestionState with _$QuestionState {
  factory QuestionState({
    required String question,
    required bool isLoading,
    String? errorMessage,
  }) = _QuestionState;
}
