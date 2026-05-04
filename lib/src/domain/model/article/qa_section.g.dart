// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qa_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QaSection _$QaSectionFromJson(Map<String, dynamic> json) => _QaSection(
  id: (json['id'] as num?)?.toInt() ?? 0,
  title: json['title'] as String? ?? '',
  description: json['description'] as String?,
  trackingLabel: json['tracking_label'] as String?,
  qaItemBlock:
      (json['qa_item_block'] as List<dynamic>?)
          ?.map((e) => QaItemBlock.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$QaSectionToJson(_QaSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'tracking_label': instance.trackingLabel,
      'qa_item_block': instance.qaItemBlock,
    };

_QaItemBlock _$QaItemBlockFromJson(Map<String, dynamic> json) => _QaItemBlock(
  id: (json['id'] as num?)?.toInt() ?? 0,
  question: json['question'] as String? ?? '',
  answer: json['answer'] as String? ?? '',
  image: json['image'] as String?,
  highlightQuote: json['highlight_quote'] as String?,
  imageRatio: json['image_ratio'] as String? ?? 'landscape_4_3',
  gallery:
      (json['gallery'] as List<dynamic>?)
          ?.map((e) => GalleryItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$QaItemBlockToJson(_QaItemBlock instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
      'image': instance.image,
      'highlight_quote': instance.highlightQuote,
      'image_ratio': instance.imageRatio,
      'gallery': instance.gallery,
    };

_GalleryItem _$GalleryItemFromJson(Map<String, dynamic> json) => _GalleryItem(
  id: (json['id'] as num?)?.toInt() ?? 0,
  directusFilesId: json['directus_files_id'] as String? ?? '',
);

Map<String, dynamic> _$GalleryItemToJson(_GalleryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'directus_files_id': instance.directusFilesId,
    };
