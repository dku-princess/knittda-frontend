// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Article _$ArticleFromJson(Map<String, dynamic> json) => _Article(
  id: (json['id'] as num?)?.toInt() ?? 0,
  title: json['title'] as String? ?? '',
  subtitle: json['subtitle'] as String? ?? '',
  category: json['category'] as String? ?? '',
  editor: json['editor'] as String? ?? '',
  interviewee: json['interviewee'] as String? ?? '',
  thumbnailImageLarge: json['thumbnail_image_large'] as String? ?? '',
  thumbnailImageSmall: json['thumbnail_image_small'] as String? ?? '',
  coverImage: json['cover_image'] as String?,
  publishedAt: json['published_at'] as String? ?? '',
  isFeatured: json['is_featured'] as bool? ?? false,
  slug: json['slug'] as String? ?? '',
  status: json['status'] as String? ?? '',
  sections: (json['sections'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$ArticleToJson(_Article instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'category': instance.category,
  'editor': instance.editor,
  'interviewee': instance.interviewee,
  'thumbnail_image_large': instance.thumbnailImageLarge,
  'thumbnail_image_small': instance.thumbnailImageSmall,
  'cover_image': instance.coverImage,
  'published_at': instance.publishedAt,
  'is_featured': instance.isFeatured,
  'slug': instance.slug,
  'status': instance.status,
  'sections': instance.sections,
};
