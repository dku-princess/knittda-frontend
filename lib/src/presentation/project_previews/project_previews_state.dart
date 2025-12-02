import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/project_previews.dart';

part 'project_previews_state.freezed.dart';

@freezed
abstract class ProjectPreviewsState with _$ProjectPreviewsState {
  factory ProjectPreviewsState(
    List<ProjectPreviews> projectPreviews,
    bool isLoading,
    String? errorMessage,
  ) = _ProjectPreviewsState;
}
