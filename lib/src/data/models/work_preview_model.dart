class WorkPreviewModel {
  final int projectId;
  final String? userName;
  final String projectName;
  final int recordNum;
  final DateTime? lastRecordAt;
  final List<String>? recentImageUrls;

  WorkPreviewModel({
    required this.projectId,
    this.userName,
    required this.projectName,
    required this.recordNum,
    this.lastRecordAt,
    this.recentImageUrls,
  });

  factory WorkPreviewModel.fromJson(Map<String, dynamic> json) {
    return WorkPreviewModel(
      projectId: json['projectId'],
      userName: json['userName'],
      projectName: json['projectName'],
      recordNum: json['recordNum'],
      lastRecordAt: json['lastRecordAt'] != null
          ? DateTime.parse(json['lastRecordAt'])
          : null,
      recentImageUrls: (json['recentImageUrls'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

}