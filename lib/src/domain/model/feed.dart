import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/record.dart';

part 'feed.freezed.dart';

part 'feed.g.dart';

@freezed
abstract class Feed with _$Feed {
  factory Feed({
    required String userName,
    required String profileImageUrl,
    required String projectName,
    String? designTitle,
    String? designer,
    required int projectId,
    required Record record,
  }) = _Feed;

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);
}
