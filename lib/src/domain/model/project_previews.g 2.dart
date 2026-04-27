// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_previews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProjectPreviews _$ProjectPreviewsFromJson(Map<String, dynamic> json) =>
    _ProjectPreviews(
      projectId: (json['projectId'] as num).toInt(),
      userName: json['userName'] as String?,
      projectName: json['projectName'] as String,
      recordNum: (json['recordNum'] as num).toInt(),
      lastRecordAt: json['lastRecordAt'] == null
          ? null
          : DateTime.parse(json['lastRecordAt'] as String),
      recentImageUrls: (json['recentImageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProjectPreviewsToJson(_ProjectPreviews instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'userName': instance.userName,
      'projectName': instance.projectName,
      'recordNum': instance.recordNum,
      'lastRecordAt': instance.lastRecordAt?.toIso8601String(),
      'recentImageUrls': instance.recentImageUrls,
    };
