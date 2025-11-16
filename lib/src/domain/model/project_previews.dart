import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_previews.freezed.dart';

part 'project_previews.g.dart';

@freezed
abstract class ProjectPreviews with _$ProjectPreviews {
  factory ProjectPreviews({
    required int projectId,
    String? userName,
    required String projectName,
    required int recordNum,
    DateTime? lastRecordAt,
    List<String>? recentImageUrls,
  }) = _ProjectPreviews;

  factory ProjectPreviews.fromJson(Map<String, dynamic> json) =>
      _$ProjectPreviewsFromJson(json);
}
