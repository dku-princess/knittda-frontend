import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/announcement.dart';

part 'announcement_state.freezed.dart';

@freezed
abstract class AnnouncementState with _$AnnouncementState {
  const AnnouncementState._();

  const factory AnnouncementState({
    @Default([]) List<Announcement> announcements,
    @Default(false) bool isLoading,
    String? errorMessage,

    @Default(false) bool isLoadingMore,
    @Default(0) int totalCount,
  }) = _AnnouncementState;

  bool get hasMore => announcements.length < totalCount;
}
