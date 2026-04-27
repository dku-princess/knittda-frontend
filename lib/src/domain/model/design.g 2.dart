// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'design.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Design _$DesignFromJson(Map<String, dynamic> json) => _Design(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  designer: json['designer'] as String?,
  needleInfo: json['needleInfo'] as String?,
  yarnInfo: json['yarnInfo'] as String?,
  description: json['description'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$DesignToJson(_Design instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'designer': instance.designer,
  'needleInfo': instance.needleInfo,
  'yarnInfo': instance.yarnInfo,
  'description': instance.description,
  'createdAt': instance.createdAt?.toIso8601String(),
};
