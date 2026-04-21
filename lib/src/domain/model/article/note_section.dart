import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_section.freezed.dart';
part 'note_section.g.dart';

@freezed
abstract class NoteSection with _$NoteSection {
  const factory NoteSection({
    @Default(0) int id,
    @JsonKey(name: 'copyright_item_block') String? copyrightItemBlock,
    @JsonKey(name: 'note_item_block') String? noteItemBlock,
    @JsonKey(name: 'tracking_label') String? trackingLabel,
  }) = _NoteSection;

  factory NoteSection.fromJson(Map<String, dynamic> json) =>
      _$NoteSectionFromJson(json);
}
