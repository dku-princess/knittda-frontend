import 'package:freezed_annotation/freezed_annotation.dart';

part 'design.freezed.dart';

part 'design.g.dart';

@freezed
abstract class Design with _$Design {
  factory Design({
    int? id,
    required String? title,
    required String? designer,
    required String? needleInfo,
    required String? yarnInfo,
    required String? description,
    DateTime? createdAt,
}) = _Design;

  factory Design.fromJson(Map<String, dynamic> json) => _$DesignFromJson(json);
}
