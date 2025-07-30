import 'package:knittda/src/data/models/record_model.dart';

class FeedModel {
  final String? userName;
  final String? profileImageUrl;
  final String projectName;
  final int projectId;
  final RecordModel record;

  FeedModel({
    this.userName,
    this.profileImageUrl,
    required this.projectName,
    required this.projectId,
    required this.record
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      userName: json['userName'],
      profileImageUrl: json['profileImageUrl'],
      projectName: json['projectName'],
      projectId: json['projectId'],
      record: RecordModel.fromJson(json['record']),
    );
  }
}