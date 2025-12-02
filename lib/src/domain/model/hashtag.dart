import 'package:freezed_annotation/freezed_annotation.dart';

part 'hashtag.freezed.dart';

part 'hashtag.g.dart';

@freezed
abstract class Hashtag with _$Hashtag {
  factory Hashtag({
    required String? hashtag,
    required String? description,
}) = _Hashtag;
      factory Hashtag.fromJson(Map<String, dynamic> json) => _$HashtagFromJson(json);
}