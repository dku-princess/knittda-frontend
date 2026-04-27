// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'records.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Records _$RecordsFromJson(Map<String, dynamic> json) => _Records(
  id: (json['id'] as num?)?.toInt(),
  projectId: (json['projectId'] as num).toInt(),
  recordStatus: json['recordStatus'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  comment: json['comment'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  images: (json['images'] as List<dynamic>?)
      ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
      .toList(),
  question: json['question'] as String?,
  recordId: (json['recordId'] as num?)?.toInt(),
);

Map<String, dynamic> _$RecordsToJson(_Records instance) => <String, dynamic>{
  'id': instance.id,
  'projectId': instance.projectId,
  'recordStatus': instance.recordStatus,
  'tags': instance.tags,
  'comment': instance.comment,
  'createdAt': instance.createdAt?.toIso8601String(),
  'images': instance.images,
  'question': instance.question,
  'recordId': instance.recordId,
};
