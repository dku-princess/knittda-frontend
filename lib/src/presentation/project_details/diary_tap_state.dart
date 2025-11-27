import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/records.dart';

part 'diary_tap_state.freezed.dart';

@freezed
abstract class DiaryTapState with _$DiaryTapState {
  factory DiaryTapState({
    required List<Records> records,
    required bool isLoading,
    String? errorMessage,
  }) = _DiaryTapState;
}
