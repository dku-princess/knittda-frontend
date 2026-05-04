// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Images _$ImagesFromJson(Map<String, dynamic> json) => _Images(
  id: (json['id'] as num).toInt(),
  imageUrl: json['imageUrl'] as String,
  imageOrder: (json['imageOrder'] as num).toInt(),
);

Map<String, dynamic> _$ImagesToJson(_Images instance) => <String, dynamic>{
  'id': instance.id,
  'imageUrl': instance.imageUrl,
  'imageOrder': instance.imageOrder,
};
