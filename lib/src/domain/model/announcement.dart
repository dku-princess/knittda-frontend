import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement.freezed.dart';

part 'announcement.g.dart';

@freezed
abstract class Announcement with _$Announcement {
  const Announcement._();

  factory Announcement({
    required int id,
    String? status,
    @JsonKey(name: 'is_pinned') bool? isPinned,
    String? title,
    String? slug,
    String? description,
    String? category,
    @JsonKey(name: 'published_at') DateTime? publishedAt,
    required String body,
    @JsonKey(name: 'tracking_label') String? trackingLabel,
  }) = _Announcement;

  factory Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);

  String get categoryLabel {
    switch (category) {
      case 'notice':
        return '공지';
      case 'event':
        return '이벤트';
      case 'update':
        return '업데이트';
      default:
        return '공지';
    }
  }
}
