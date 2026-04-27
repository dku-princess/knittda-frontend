// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProjectSection _$ProjectSectionFromJson(Map<String, dynamic> json) =>
    _ProjectSection(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      projectItemBlock:
          (json['project_item_block'] as List<dynamic>?)
              ?.map((e) => ProjectItemBlock.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProjectSectionToJson(_ProjectSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'project_item_block': instance.projectItemBlock,
    };

_ProjectItemBlock _$ProjectItemBlockFromJson(Map<String, dynamic> json) =>
    _ProjectItemBlock(
      id: (json['id'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? '',
      projectId: (json['project_id'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProjectItemBlockToJson(_ProjectItemBlock instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'project_id': instance.projectId,
    };
