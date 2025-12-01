import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/model/user.dart';
import 'package:knittda/src/presentation/project_details/diary_tap_state.dart';

part 'project_details_state.freezed.dart';

@freezed
abstract class ProjectDetailsState with _$ProjectDetailsState {
  factory ProjectDetailsState({
    required Project? project,
    required bool isLoading,
    required bool isOwner,
    required User? user,
    required DiaryTapState diaryTapState,
  }) = _ProjectDetailsState;
}
