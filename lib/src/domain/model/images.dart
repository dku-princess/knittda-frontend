import 'package:freezed_annotation/freezed_annotation.dart';

part 'images.freezed.dart';

part 'images.g.dart';

@freezed
abstract class Images with _$Images {
  factory Images({
    required int id,
    required String imageUrl,
    required int imageOrder,
  }) = _Images;

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
}
