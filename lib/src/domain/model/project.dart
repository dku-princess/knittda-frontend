import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/design.dart';

part 'project.freezed.dart';

part 'project.g.dart';

@freezed
abstract class Project with _$Project {
  factory Project({
    int? id,
    Design? design,
    int? userId,
    required String nickname,
    String? status,
    String? thumbnailUrl,
    DateTime? lastRecordAt,
    DateTime? createdAt,
    required String startDate,
    String? endDate,
    required String goalDate,

    int? projectId,
    String? yarnInfo,
    String? needleInfo,
    String? designTitle,
    String? designer,
    bool? visible,
}) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}
