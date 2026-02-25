import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/feed.dart';

part 'feed_search_state.freezed.dart';

@freezed
abstract class FeedSearchState with _$FeedSearchState {
  factory FeedSearchState({
    required List<Feed> feeds,
    required bool isLoading,

    required String keyword,
    required int page,
    required bool hasMore,
    required bool isLoadingMore,
    String? searchId,
    String? searchVersion,
  }) = _FeedSearchState;
}