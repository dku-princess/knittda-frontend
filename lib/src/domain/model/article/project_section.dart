import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_section.freezed.dart';

part 'project_section.g.dart';

@freezed
abstract class ProjectSection with _$ProjectSection {
  const factory ProjectSection({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String description,
    @JsonKey(name: 'project_item_block') @Default([]) List<ProjectItemBlock> projectItemBlock,

    @JsonKey(name: 'date_created') String? dateCreated,
    @JsonKey(name: 'date_updated') String? dateUpdated,
    @JsonKey(name: 'user_created') String? userCreated,
}) = _ProjectSection;

  factory ProjectSection.fromJson(Map<String, dynamic> json) => _$ProjectSectionFromJson(json);
}

@freezed
abstract class ProjectItemBlock with _$ProjectItemBlock {
  const factory ProjectItemBlock({
    @Default(0) int id,
    @Default('') String status,
    @JsonKey(name: 'project_id') @Default(0) int projectId,

    @JsonKey(name: 'date_created') String? dateCreated,
    @JsonKey(name: 'date_updated') String? dateUpdated,
    @JsonKey(name: 'user_created') String? userCreated,
    @JsonKey(name: 'project_section_id') int? projectSectionId,
  }) = _ProjectItemBlock;

  factory ProjectItemBlock.fromJson(Map<String, dynamic> json) =>
      _$ProjectItemBlockFromJson(json);
}