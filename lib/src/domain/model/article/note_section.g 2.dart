// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoteSection _$NoteSectionFromJson(Map<String, dynamic> json) => _NoteSection(
  id: (json['id'] as num?)?.toInt() ?? 0,
  copyrightItemBlock: json['copyright_item_block'] as String?,
  noteItemBlock: json['note_item_block'] as String?,
  trackingLabel: json['tracking_label'] as String?,
);

Map<String, dynamic> _$NoteSectionToJson(_NoteSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'copyright_item_block': instance.copyrightItemBlock,
      'note_item_block': instance.noteItemBlock,
      'tracking_label': instance.trackingLabel,
    };
