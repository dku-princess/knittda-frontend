import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_previews_event.freezed.dart';

@freezed
sealed class ProjectPreviewsEvent with _$ProjectPreviewsEvent {
  const factory ProjectPreviewsEvent.loadProjectPreviews() = LoadProjectPreviews;
  const factory ProjectPreviewsEvent.loadMore() = LoadMore;
}
