import 'package:freezed_annotation/freezed_annotation.dart';

part 'pattern_section.freezed.dart';

part 'pattern_section.g.dart';

@freezed
abstract class PatternSection with _$PatternSection {
  const factory PatternSection({
    @Default(0) int id,
    @Default('') String title,
    String? description,
    @JsonKey(name: 'tracking_label') String? trackingLabel,
    @JsonKey(name: 'pattern_item_block') @Default([]) List<PatternItemBlock> patternItemBlock,
  }) = _PatternSection;

  factory PatternSection.fromJson(Map<String, dynamic> json) =>
      _$PatternSectionFromJson(json);
}

@freezed
abstract class PatternItemBlock with _$PatternItemBlock {
  const factory PatternItemBlock({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String description,
    String? image,
  }) = _PatternItemBlock;

  factory PatternItemBlock.fromJson(Map<String, dynamic> json) =>
      _$PatternItemBlockFromJson(json);
}