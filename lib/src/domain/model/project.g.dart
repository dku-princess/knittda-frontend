// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Project _$ProjectFromJson(Map<String, dynamic> json) => _Project(
  id: (json['id'] as num?)?.toInt(),
  design: json['design'] == null
      ? null
      : Design.fromJson(json['design'] as Map<String, dynamic>),
  userId: (json['userId'] as num?)?.toInt(),
  nickname: json['nickname'] as String,
  status: json['status'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  lastRecordAt: json['lastRecordAt'] == null
      ? null
      : DateTime.parse(json['lastRecordAt'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String?,
  goalDate: json['goalDate'] as String,
  projectId: (json['projectId'] as num?)?.toInt(),
  yarnInfo: json['yarnInfo'] as String?,
  needleInfo: json['needleInfo'] as String?,
  designTitle: json['designTitle'] as String?,
  designer: json['designer'] as String?,
  visible: json['visible'] as bool?,
);

Map<String, dynamic> _$ProjectToJson(_Project instance) => <String, dynamic>{
  'id': instance.id,
  'design': instance.design,
  'userId': instance.userId,
  'nickname': instance.nickname,
  'status': instance.status,
  'thumbnailUrl': instance.thumbnailUrl,
  'lastRecordAt': instance.lastRecordAt?.toIso8601String(),
  'createdAt': instance.createdAt?.toIso8601String(),
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'goalDate': instance.goalDate,
  'projectId': instance.projectId,
  'yarnInfo': instance.yarnInfo,
  'needleInfo': instance.needleInfo,
  'designTitle': instance.designTitle,
  'designer': instance.designer,
  'visible': instance.visible,
};
