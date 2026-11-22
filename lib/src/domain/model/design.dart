import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/needle.dart';
import 'package:knittda/src/domain/model/yarn.dart';

part 'design.freezed.dart';

part 'design.g.dart';

@freezed
abstract class Design with _$Design {
  factory Design({
    int? id,
    required String? title,
    required String? designer,
    required String? description,
    List<Yarn>? yarns,
    List<Needle>? needles,
    DateTime? createdAt,
  }) = _Design;

  factory Design.fromJson(Map<String, dynamic> json) => _$DesignFromJson(json);
}
