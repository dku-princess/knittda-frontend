import 'package:freezed_annotation/freezed_annotation.dart';

part 'default_thumbnail.freezed.dart';

part 'default_thumbnail.g.dart';

@freezed
abstract class DefaultThumbnail with _$DefaultThumbnail {
  factory DefaultThumbnail({
    required int id,
    required String name,
    required String imageUrl,
  }) = _DefaultThumbnail;

  factory DefaultThumbnail.fromJson(Map<String, dynamic> json) =>
      _$DefaultThumbnailFromJson(json);
}
