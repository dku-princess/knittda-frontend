// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Report _$ReportFromJson(Map<String, dynamic> json) => _Report(
  knittingLevel: (json['knittingLevel'] as num).toDouble(),
  weeklyKnittingCount: (json['weeklyKnittingCount'] as num).toInt(),
  weeklyKnittingPhotoCount: (json['weeklyKnittingPhotoCount'] as num).toInt(),
  weeklyProgress: (json['weeklyProgress'] as num).toInt(),
  topTags: (json['topTags'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  weeklyHashtags: (json['weeklyHashtags'] as List<dynamic>?)
      ?.map((e) => Hashtag.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ReportToJson(_Report instance) => <String, dynamic>{
  'knittingLevel': instance.knittingLevel,
  'weeklyKnittingCount': instance.weeklyKnittingCount,
  'weeklyKnittingPhotoCount': instance.weeklyKnittingPhotoCount,
  'weeklyProgress': instance.weeklyProgress,
  'topTags': instance.topTags,
  'weeklyHashtags': instance.weeklyHashtags,
};
