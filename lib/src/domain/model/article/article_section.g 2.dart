// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArticleSection _$ArticleSectionFromJson(Map<String, dynamic> json) =>
    _ArticleSection(
      id: (json['id'] as num?)?.toInt() ?? 0,
      articlesId: (json['articles_id'] as num?)?.toInt() ?? 0,
      collection: json['collection'] as String? ?? '',
      sort: (json['sort'] as num?)?.toInt() ?? 0,
      item: json['item'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ArticleSectionToJson(_ArticleSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'articles_id': instance.articlesId,
      'collection': instance.collection,
      'sort': instance.sort,
      'item': instance.item,
    };
