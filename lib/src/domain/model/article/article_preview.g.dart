// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArticlePreview _$ArticlePreviewFromJson(Map<String, dynamic> json) =>
    _ArticlePreview(
      projectId: (json['projectId'] as num).toInt(),
      projectName: json['projectName'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      nickname: json['nickname'] as String?,
    );

Map<String, dynamic> _$ArticlePreviewToJson(_ArticlePreview instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'thumbnailUrl': instance.thumbnailUrl,
      'nickname': instance.nickname,
    };

_ArticlePreviewData _$ArticlePreviewDataFromJson(Map<String, dynamic> json) =>
    _ArticlePreviewData(
      num: (json['num'] as num).toInt(),
      projects: (json['projects'] as List<dynamic>)
          .map((e) => ArticlePreview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticlePreviewDataToJson(_ArticlePreviewData instance) =>
    <String, dynamic>{'num': instance.num, 'projects': instance.projects};
