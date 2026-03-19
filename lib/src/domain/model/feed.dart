import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/records.dart';

part 'feed.freezed.dart';

part 'feed.g.dart';

@freezed
abstract class Feed with _$Feed {
  factory Feed({
    String? userName,
    String? profileImageUrl,
    required String projectName,
    String? designTitle,
    String? designer,
    required int projectId,
    required Records record,
  }) = _Feed;

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);
}
