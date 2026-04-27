// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pattern_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PatternSection _$PatternSectionFromJson(Map<String, dynamic> json) =>
    _PatternSection(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      trackingLabel: json['tracking_label'] as String?,
      patternItemBlock:
          (json['pattern_item_block'] as List<dynamic>?)
              ?.map((e) => PatternItemBlock.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PatternSectionToJson(_PatternSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'tracking_label': instance.trackingLabel,
      'pattern_item_block': instance.patternItemBlock,
    };

_PatternItemBlock _$PatternItemBlockFromJson(Map<String, dynamic> json) =>
    _PatternItemBlock(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: json['image'] as String?,
      imageRatio: json['image_ratio'] as String? ?? 'landscape_4_3',
      gallery:
          (json['gallery'] as List<dynamic>?)
              ?.map((e) => GalleryItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      gallerySecond:
          (json['gallery_second'] as List<dynamic>?)
              ?.map((e) => GalleryItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PatternItemBlockToJson(_PatternItemBlock instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'image_ratio': instance.imageRatio,
      'gallery': instance.gallery,
      'gallery_second': instance.gallerySecond,
    };
