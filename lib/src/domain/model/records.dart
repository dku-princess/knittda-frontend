import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/images.dart';

part 'records.freezed.dart';

part 'records.g.dart';

@freezed
abstract class Records with _$Records {
  factory Records({
    int? id,
    required int projectId,
    required String? recordStatus,
    required List<String>? tags,
    required String? comment,
    DateTime? createdAt,
    List<Images>? images,

    String? question,
    int? recordId,

  }) = _Records;

  factory Records.fromJson(Map<String, dynamic> json) => _$RecordsFromJson(json);
}
