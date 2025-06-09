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
      knittingLevel: json['knittingLevel']?.toDouble() ?? 0.0,
      weeklyKnittingCount: json['weeklyKnittingCount'] ?? 0,
      weeklyKnittingPhotoCount: json['weeklyKnittingPhotoCount'] ?? 0,
      weeklyProgress: json['weeklyProgress'] ?? 0,
      topTags: (json['topTags'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      weeklyHashtags: (json['weeklyHashtags'] as List<dynamic>?)
          ?.map((e) => HashtagModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'knittingLevel': knittingLevel,
    'weeklyKnittingCount': weeklyKnittingCount,
    'weeklyKnittingPhotoCount': weeklyKnittingPhotoCount,
    'weeklyProgress': weeklyProgress,
    'topTags': topTags,
    'weeklyHashtags': weeklyHashtags
        ?.map((e) => e.toJson())
        .toList(),
  };
}
