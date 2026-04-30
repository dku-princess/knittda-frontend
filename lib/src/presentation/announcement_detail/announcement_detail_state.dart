import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/announcement.dart';

part 'announcement_detail_state.freezed.dart';

@freezed
abstract class AnnouncementDetailState with _$AnnouncementDetailState {
  factory AnnouncementDetailState({
    required Announcement? announcement,
    required bool isLoading,
    String? errorMessage,
  }) = _AnnouncementDetailState;
}
