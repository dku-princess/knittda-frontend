import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_search_event.freezed.dart';

@freezed
sealed class FeedSearchEvent with _$FeedSearchEvent {
  const factory FeedSearchEvent.searchFeed(String keyword, int page, int size, List<String>? sort) = SearchFeed;
  const factory FeedSearchEvent.loadNext(int size, List<String>? sort) = LoadNext;
  const factory FeedSearchEvent.clear() = Clear;
}