import 'package:freezed_annotation/freezed_annotation.dart';

part 'in_app_banner.freezed.dart';

part 'in_app_banner.g.dart';

@freezed
abstract class InAppBanner with _$InAppBanner {
  factory InAppBanner({
    required int id,
    required String status,
    String? title,
    String? description,
    @JsonKey(name: 'thumbnail_image') String? thumbnailImage,
    @JsonKey(name: 'tracking_label') String? trackingLabel,
    required int priority,
    @JsonKey(name: 'start_at') DateTime? startAt,
    @JsonKey(name: 'end_at') DateTime? endAt,

    @JsonKey(name: 'is_active') required bool isActive,
    required String placement,
    @JsonKey(name: 'show_once_per_day') required bool showOncePerDay,
    @JsonKey(name: 'audience_type') required String audienceType,
    @JsonKey(name: 'min_app_version') String? minAppVersion,
    @JsonKey(name: 'max_app_version') String? maxAppVersion,

    @JsonKey(name: 'action_type') required String actionType,
    @JsonKey(name: 'target_type') String? targetType,
    @JsonKey(name: 'target_id') int? targetId,
    @JsonKey(name: 'target_route') String? targetRoute,
    @JsonKey(name: 'external_url') String? externalUrl,
  }) = _InAppBanner;

  factory InAppBanner.fromJson(Map<String, dynamic> json) =>
      _$InAppBannerFromJson(json);
}
