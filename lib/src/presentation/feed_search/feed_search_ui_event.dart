import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_search_ui_event.freezed.dart';

@freezed
sealed class FeedSearchUiEvent with _$FeedSearchUiEvent {
  const factory FeedSearchUiEvent.showSnackBar(String message) = ShowSnackBar;
}
