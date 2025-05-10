class WorkModel {
  final int id;
  final int designId;
  final int? userId;
  final String nickname;
  final String? status;
  final String customYarnInfo;
  final String customNeedleInfo;
  final DateTime? lastRecordAt;
  final DateTime? createdAt;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime goalDate;

  WorkModel({
    required this.id,
    required this.designId,
    this.userId,//
    required this.nickname,
    this.status,//
    required this.customYarnInfo,
    required this.customNeedleInfo,
    this.lastRecordAt,//
    this.createdAt,//
    required this.startDate,
    required this.endDate,
    required this.goalDate,

  });

  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
      id: json['id'],
      designId: json['designId'],
      userId: json['userId'],
      nickname: json['nickname'],
      status: json['status'],
      customYarnInfo: json['customYarnInfo'],
      customNeedleInfo: json['customNeedleInfo'],
      lastRecordAt: json['lastRecordAt'] != null ? DateTime.parse(json['lastRecordAt']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      goalDate: DateTime.parse(json['goalDate']),
    );
  }

  Map<String, dynamic> toJson() {  // ➋ 모델을 다시 JSON으로 변환하는 함수
    return {
      'id': id,
      'designId': designId,
      'userId': userId,
      'nickname': nickname,
      'status': status,
      'customYarnInfo': customYarnInfo,
      'customNeedleInfo': customNeedleInfo,
      'lastRecordAt': lastRecordAt?.toIso8601String(),
      'createdAt': createdAt != null
          ? '${createdAt!.year}${createdAt!.month.toString().padLeft(2, '0')}${createdAt!.day.toString().padLeft(2, '0')}'
          : null,
      'startDate': '${startDate.year}${startDate.month.toString().padLeft(2, '0')}${startDate.day.toString().padLeft(2, '0')}',
      'endDate': '${endDate.year}${endDate.month.toString().padLeft(2, '0')}${endDate.day.toString().padLeft(2, '0')}',
      'goalDate': '${goalDate.year}${goalDate.month.toString().padLeft(2, '0')}${goalDate.day.toString().padLeft(2, '0')}',
    };
  }

  WorkModel copyWith({
    int? id,
    int? designId,
    int? userId,
    String? nickname,
    String? status,
    String? customYarnInfo,
    String? customNeedleInfo,
    DateTime? lastRecordAt,
    DateTime? createdAt,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? goalDate,
  }) {
    return WorkModel(
      id: id ?? this.id,
      designId: designId ?? this.designId,
      userId: userId ?? this.userId,
      nickname: nickname ?? this.nickname,
      status: status ?? this.status,
      customYarnInfo: customYarnInfo ?? this.customYarnInfo,
      customNeedleInfo: customNeedleInfo ?? this.customNeedleInfo,
      lastRecordAt: lastRecordAt ?? this.lastRecordAt,
      createdAt: createdAt ?? this.createdAt,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      goalDate: goalDate ?? this.goalDate,
    );
  }
}
