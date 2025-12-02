import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_event.freezed.dart';

@freezed
sealed class FeedEvent with _$FeedEvent {
  const factory FeedEvent.loadFeed(int page, int size, List<String>? sort) = LoadFeed;
  const factory FeedEvent.refresh(int size, List<String>? sort) = Refresh;
  const factory FeedEvent.loadNext(int size, List<String>? sort) = LoadNext;
}
