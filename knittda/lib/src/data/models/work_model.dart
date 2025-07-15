import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/models/design_model.dart';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class WorkModel {
  final String nickname;
  final String? customYarnInfo;
  final String? customNeedleInfo;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? goalDate;
  final XFile? file;
  final String? designTitle;
  final String? designer;
  final bool? visible;

  final int? id;
  final DesignModel? design;
  final int? userId;
  final String? status;
  final String? thumbnailUrl;
  final DateTime? lastRecordAt;
  final DateTime? createdAt;

  WorkModel({
    required this.nickname,
    this.customYarnInfo,
    this.customNeedleInfo,
    this.startDate,
    this.endDate,
    this.goalDate,
    this.file,
    this.designTitle,
    this.designer,
    this.visible,

    this.id,
    this.design,
    this.userId,
    this.status,
    this.thumbnailUrl,
    this.lastRecordAt,
    this.createdAt,
  });

  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
      nickname: json['nickname'],
      customYarnInfo: null,
      customNeedleInfo: null,
      startDate: json['startDate'] != null
          ? DateTime.tryParse(json['startDate'])
          : null,
      endDate: json['endDate'] != null
          ? DateTime.tryParse(json['endDate'])
          : null,
      goalDate: json['goalDate'] != null
          ? DateTime.tryParse(json['goalDate'])
          : null,
      file: null,
      designTitle: null,
      designer: null,
      visible: null,

      id: json['id'],
      design: json['design'] != null ? DesignModel.fromJson(json['design']) : null,
      userId: json['userId'],
      status: json['status'],
      thumbnailUrl: json['thumbnailUrl'],
      lastRecordAt: json['lastRecordAt'] != null
          ? DateTime.parse(json['lastRecordAt'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  factory WorkModel.forCreate({
    required String nickname,
    String? customYarnInfo,
    String? customNeedleInfo,
    DateTime? startDate,
    DateTime? endDate,
    required DateTime goalDate,
    required XFile file,
    String? designTitle,
    String? designer,
    bool visible = false,
  }) {
    return WorkModel(
      nickname: nickname,
      customYarnInfo: customYarnInfo,
      customNeedleInfo: customNeedleInfo,
      startDate: startDate,
      endDate: endDate,
      goalDate: goalDate,
      file: file,
      designTitle: designTitle,
      designer: designer,
      visible: visible,

      id: null,
      design: null,
      userId: null,
      status: null,
      lastRecordAt: null,
      createdAt: null,
      thumbnailUrl: null,
    );
  }

  WorkModel copyWith({
    int? id,
    DesignModel? design,
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
    String? thumbnailUrl,
    XFile? file,
    String? designTitle,
    String? designer,
    bool? visible,
  }) {
    return WorkModel(
      id: id ?? this.id,
      design: design ?? this.design,
      userId: userId ?? this.userId,
      nickname: nickname ?? this.nickname,
      status: status ?? this.status,
      customYarnInfo: customYarnInfo ?? this.customYarnInfo,
      customNeedleInfo: customNeedleInfo ?? this.customNeedleInfo,
      lastRecordAt: lastRecordAt ?? this.lastRecordAt,
      createdAt: createdAt ?? this.createdAt,
      startDate: startDate ?? this.startDate,
      endDate: endDate,
      goalDate: goalDate ?? this.goalDate,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      file: file ?? this.file,
      designTitle: designTitle ?? this.designTitle,
      designer: designer ?? this.designer,
      visible: visible ?? this.visible,
    );
  }
}


extension WorkModelMultipart on WorkModel {
  Future<FormData> toMultipartForm() async {
    final form = FormData();

    form.fields.add(MapEntry(
      'project',
      jsonEncode({
        'projectId': id,
        'nickname': nickname,
        'yarnInfo': customYarnInfo,
        'needleInfo': customNeedleInfo,
        'status': status,
        'startDate': startDate != null ? DateUtilsHelper.toHyphenFormat(startDate!) : null,
        'endDate': endDate != null ? DateUtilsHelper.toHyphenFormat(endDate!) : null,
        'goalDate': goalDate != null ? DateUtilsHelper.toHyphenFormat(goalDate!) : null,
        'designTitle': designTitle,
        'designer': designer,
        'visible': visible,
      }),
    ));

    if (file != null) {
      form.files.add(MapEntry(
        'file',
        await MultipartFile.fromFile(
          file!.path,
          filename: file!.name,
          contentType: MediaType('image', 'jpeg'),
        ),
      ));
    }

    return form;
  }
}

// Map<String, dynamic> toJson() {
//   return {
//     'project': {
//       // 'projectId': id,
//       // 'designId': designId,
//       // 'nickname': nickname,
//       // 'customYarnInfo': customYarnInfo ?? '',
//       // 'customNeedleInfo': customNeedleInfo ?? '',
//       // 'startDate': startDate != null ? DateUtilsHelper.toHyphenFormat(startDate!) : null,
//       // 'endDate': endDate != null ? DateUtilsHelper.toHyphenFormat(endDate!) : null,
//       // 'goalDate': goalDate != null ? DateUtilsHelper.toHyphenFormat(goalDate!) : null,
//       // 'title': title,
//       // 'designer': designer,
//       // 'visible': false,
//       'status': status
//     },
//     //'file': file?.path,
//   };
// }