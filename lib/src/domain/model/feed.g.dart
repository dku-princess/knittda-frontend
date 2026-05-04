// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Feed _$FeedFromJson(Map<String, dynamic> json) => _Feed(
  userName: json['userName'] as String?,
  profileImageUrl: json['profileImageUrl'] as String?,
  projectName: json['projectName'] as String,
  designTitle: json['designTitle'] as String?,
  designer: json['designer'] as String?,
  projectId: (json['projectId'] as num).toInt(),
  record: Records.fromJson(json['record'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FeedToJson(_Feed instance) => <String, dynamic>{
  'userName': instance.userName,
  'profileImageUrl': instance.profileImageUrl,
  'projectName': instance.projectName,
  'designTitle': instance.designTitle,
  'designer': instance.designer,
  'projectId': instance.projectId,
  'record': instance.record,
};
