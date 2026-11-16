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
    required String? needleInfo,
    required String? yarnInfo,
    required String? description,
    DateTime? createdAt,

    // v2 응답에만 있다. v1 응답(상세 화면)에서는 null.
    List<Yarn>? yarns,
    List<Needle>? needles,
  }) = _Design;

  factory Design.fromJson(Map<String, dynamic> json) => _$DesignFromJson(json);
}
