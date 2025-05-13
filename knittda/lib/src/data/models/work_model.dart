import 'package:knittda/src/core/utils/date_utils.dart';

class WorkModel {
  final int? id;
  final int? designId;
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
  final String? customDesign;
  final String? customDesigner;

  WorkModel({
    this.id,
    this.designId,
    this.userId,
    required this.nickname,
    this.status,
    required this.customYarnInfo,
    required this.customNeedleInfo,
    this.lastRecordAt,
    this.createdAt,
    required this.startDate,
    required this.endDate,
    required this.goalDate,
    this.customDesign,
    this.customDesigner,
  });

  //서버에서 json 형식으로 돌려주면 map으로 저장
  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
      id: json['id'],
      designId: json['designId'],
      userId: json['userId'],
      nickname: json['nickname'],
      status: json['status'],
      customYarnInfo: json['customYarnInfo'],
      customNeedleInfo: json['customNeedleInfo'],
      lastRecordAt: json['lastRecordAt'] != null
          ? DateTime.parse(json['lastRecordAt'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      goalDate: DateTime.parse(json['goalDate']),
    );
  }

  // map으로 된 정보를 json으로 변형해서 서버로 전송
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'designId': designId,
      'userId': userId,
      'nickname': nickname,
      'status': status,
      'customYarnInfo': customYarnInfo,
      'customNeedleInfo': customNeedleInfo,
      'lastRecordAt': lastRecordAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'startDate': DateUtilsHelper.toHyphenFormat(startDate),
      'endDate': DateUtilsHelper.toHyphenFormat(endDate),
      'goalDate': DateUtilsHelper.toHyphenFormat(goalDate),
    };
  }

  /// 작품 생성 전용
  factory WorkModel.forCreate({
    required int? designId,
    required String nickname,
    required String customYarnInfo,
    required String customNeedleInfo,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime goalDate,
    required String? customDesign,
    required String? customDesigner,
  }) {
    return WorkModel(
      designId: designId,
      nickname: nickname,
      customYarnInfo: customYarnInfo,
      customNeedleInfo: customNeedleInfo,
      startDate: startDate,
      endDate: endDate,
      goalDate: goalDate,
      customDesign: customDesign,
      customDesigner: customDesigner,
    );
  }

  /// map으로 된 정보를 json으로 변형해서 서버로 전송, 작품 생성시 사용
  Map<String, dynamic> toCreateJson() {
    return {
      'designId': designId,
      'nickname': nickname,
      'customYarnInfo': customYarnInfo,
      'customNeedleInfo': customNeedleInfo,
      'startDate': DateUtilsHelper.toHyphenFormat(startDate),
      'endDate': DateUtilsHelper.toHyphenFormat(endDate),
      'goalDate': DateUtilsHelper.toHyphenFormat(goalDate),
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
    String? customDesign,
    String? customDesigner,
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
      customDesign: customDesign ?? this.customDesign,
      customDesigner: customDesigner ?? this.customDesigner,
    );
  }
}
