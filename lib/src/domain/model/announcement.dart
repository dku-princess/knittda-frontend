import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement.freezed.dart';

part 'announcement.g.dart';

@freezed
abstract class Announcement with _$Announcement {
  factory Announcement({
    required int id,
    String? status,
    @JsonKey(name: 'is_pinned') bool? isPinned,
    String? title,
    String? slug,
    String? description,
    String? category,
    @JsonKey(name: 'published_at') required String publishedAt,
    required String body,
    @JsonKey(name: 'tracking_label') String? trackingLabel,
    @JsonKey(name: 'date_created') String? dateCreated,
    @JsonKey(name: 'date_updated') String? dateUpdated,
    @JsonKey(name: 'user_created') String? userCreated,
    @JsonKey(name: 'user_updated') String? userUpdated,
  }) = _Announcement;

  factory Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);
}
