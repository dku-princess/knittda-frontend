import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/announcement.dart';

part 'announcement_state.freezed.dart';

@freezed
abstract class AnnouncementState with _$AnnouncementState {
  const factory AnnouncementState({
    required List<Announcement> announcements,
    required bool isLoading,
    String? errorMessage,
  }) = _AnnouncementState;
}
