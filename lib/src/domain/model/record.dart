import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/images.dart';

part 'record.freezed.dart';

part 'record.g.dart';

@freezed
abstract class Record with _$Record {
  factory Record({
    int? id,
    required int projectId,
    String? recordStatus,
    List<String>? tags,
    String? comment,
    DateTime? createdAt,
    List<Images>? images,
  }) = _Record;

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
}
