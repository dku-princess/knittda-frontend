import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/feed.dart';

part 'feed_state.freezed.dart';

@freezed
abstract class FeedState with _$FeedState {
  factory FeedState({
    required List<Feed> feeds,
    required bool isLoading,
    String? errorMessage,

    required int page,
    required bool hasMore,
    required bool isLoadingMore,
  }) = _FeedState;
}
