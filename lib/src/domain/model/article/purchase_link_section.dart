import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_link_section.freezed.dart';

part 'purchase_link_section.g.dart';

@freezed
abstract class PurchaseLinkSection with _$PurchaseLinkSection {
  const factory PurchaseLinkSection({
    @Default(0) int id,
    @Default('') String title,
    String? description,
    @JsonKey(name: 'tracking_label') String? trackingLabel,
    @JsonKey(name: 'button_text') @Default('') String buttonText,
    @JsonKey(name: 'button_url') @Default('') String buttonUrl,
    @JsonKey(name: 'preview_image') String? previewImage,

    @JsonKey(name: 'date_created') String? dateCreated,
    @JsonKey(name: 'date_updated') String? dateUpdated,
    @JsonKey(name: 'user_created') String? userCreated,
  }) = _PurchaseLinkSection;

  factory PurchaseLinkSection.fromJson(Map<String, dynamic> json) =>
      _$PurchaseLinkSectionFromJson(json);
}