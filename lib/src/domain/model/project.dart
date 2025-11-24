import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/design.dart';

part 'project.freezed.dart';

part 'project.g.dart';

@freezed
abstract class Project with _$Project {
  factory Project({
    int? id,
    required Design? design,
    int? userId,
    required String? nickname,
    String? status,
    String? thumbnailUrl,
    DateTime? lastRecordAt,
    DateTime? createdAt,
    required DateTime? startDate,
    DateTime? endDate,
    required DateTime? goalDate,
}) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}
