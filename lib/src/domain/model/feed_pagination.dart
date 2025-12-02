import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/feed.dart';

part 'feed_pagination.freezed.dart';

part 'feed_pagination.g.dart';

@freezed
abstract class FeedPagination with _$FeedPagination {
  factory FeedPagination(
  {
    required int totalElements,
    required int totalPages,
    required int size,
    required List<Feed> content,
    required int number,
    required bool first,
    required bool last,
    required bool empty,
}) = _FeedPagination;

  factory FeedPagination.fromJson(Map<String, dynamic> json) => _$FeedPaginationFromJson(json);
}
