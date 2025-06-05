import 'package:knittda/src/data/models/hashtag_model.dart';

class ReportModel {
  final double knittingLevel;
  final int weeklyKnittingCount;
  final int weeklyKnittingPhotoCount;
  final int weeklyProgress;
  final List<String>? topTags;
  final List<HashtagModel>? weeklyHashtags;

  ReportModel({
    required this.knittingLevel,
    required this.weeklyKnittingCount,
    required this.weeklyKnittingPhotoCount,
    required this.weeklyProgress,
    this.topTags,
    this.weeklyHashtags,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      knittingLevel: json['knitting_level']?.toDouble() ?? 0.0,
      weeklyKnittingCount: json['weekly_knitting_count'] ?? 0,
      weeklyKnittingPhotoCount: json['weekly_knitting_photo_count'] ?? 0,
      weeklyProgress: json['weekly_progress'] ?? 0,
      topTags: (json['top_tags'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      weeklyHashtags: (json['weekly_hashtags'] as List<dynamic>?)
          ?.map((e) => HashtagModel.fromJson(e))
          .toList(),
    );
  }
}