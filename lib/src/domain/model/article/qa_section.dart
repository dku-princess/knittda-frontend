import 'package:freezed_annotation/freezed_annotation.dart';

part 'qa_section.freezed.dart';
part 'qa_section.g.dart';

@freezed
abstract class QaSection with _$QaSection {
  const factory QaSection({
    @Default(0) int id,
    @Default('') String title,
    String? description,
    @JsonKey(name: 'tracking_label') String? trackingLabel,
    @JsonKey(name: 'qa_item_block') @Default([]) List<QaItemBlock> qaItemBlock,
  }) = _QaSection;

  factory QaSection.fromJson(Map<String, dynamic> json) =>
      _$QaSectionFromJson(json);
}

@freezed
abstract class QaItemBlock with _$QaItemBlock {
  const factory QaItemBlock({
    @Default(0) int id,
    @Default('') String question,
    @Default('') String answer,
    String? image,
    @JsonKey(name: 'highlight_quote') String? highlightQuote,
    @JsonKey(name: 'image_ratio') @Default('landscape_4_3') String imageRatio,
    @Default([]) List<GalleryItem> gallery,
  }) = _QaItemBlock;

  factory QaItemBlock.fromJson(Map<String, dynamic> json) =>
      _$QaItemBlockFromJson(json);
}

@freezed
abstract class GalleryItem with _$GalleryItem {
  const factory GalleryItem({
    @Default(0) int id,
    @JsonKey(name: 'directus_files_id') @Default('') String directusFilesId,
  }) = _GalleryItem;

  factory GalleryItem.fromJson(Map<String, dynamic> json) =>
      _$GalleryItemFromJson(json);
}