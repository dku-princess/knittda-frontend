// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_link_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PurchaseLinkSection _$PurchaseLinkSectionFromJson(Map<String, dynamic> json) =>
    _PurchaseLinkSection(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      trackingLabel: json['tracking_label'] as String?,
      buttonText: json['button_text'] as String? ?? '',
      buttonUrl: json['button_url'] as String? ?? '',
      previewImage: json['preview_image'] as String?,
    );

Map<String, dynamic> _$PurchaseLinkSectionToJson(
  _PurchaseLinkSection instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'tracking_label': instance.trackingLabel,
  'button_text': instance.buttonText,
  'button_url': instance.buttonUrl,
  'preview_image': instance.previewImage,
};
