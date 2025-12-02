import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knittda/src/domain/model/hashtag.dart';

part 'report.freezed.dart';

part 'report.g.dart';

@freezed
abstract class Report with _$Report {
  factory Report({
    required double knittingLevel,
    required int weeklyKnittingCount,
    required int weeklyKnittingPhotoCount,
    required int weeklyProgress,
    required List<String>? topTags,
    required List<Hashtag>? weeklyHashtags,
}) = _Report;
      factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
}