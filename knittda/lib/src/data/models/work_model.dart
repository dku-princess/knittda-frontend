import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/models/design_model.dart';
import 'package:knittda/src/data/models/image_model.dart';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class WorkModel {
  final int? designId;
  final String nickname;
  final String? customYarnInfo;
  final String? customNeedleInfo;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? goalDate;
  final XFile? file;

  final int? id;
  final DesignModel? designDto;
  final int? userId;
  final String? status;
  final DateTime? lastRecordAt;
  final DateTime? createdAt;
  final ImageModel? image;

  final String? title;
  final String? designer;
  final bool visible;

  WorkModel({
    this.designId,
    required this.nickname,
    this.customYarnInfo,
    this.customNeedleInfo,
    this.startDate,
    this.endDate,
    this.goalDate,
    this.file,

    this.id,
    this.designDto,
    this.userId,
    this.status,
    this.lastRecordAt,
    this.createdAt,
    this.image,

    this.title,
    this.designer,
    this.visible = false,
  });

  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
      designId: json['designDto']?['id'],
      nickname: json['nickname'],
      customYarnInfo: json['customYarnInfo'],
      customNeedleInfo: json['customNeedleInfo'],
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

      id: json['id'],
      designDto: json['designDto'] != null ? DesignModel.fromJson(json['designDto']) : null,
      userId: json['userId'],
      status: json['status'],
      lastRecordAt: json['lastRecordAt'] != null
          ? DateTime.parse(json['lastRecordAt'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      image: json['image'] != null ? ImageModel.fromJson(json['image']) : null,

      title: json['title'],
      designer: json['designer'],
      visible: json['visible'] ?? false,
    );
  }

  factory WorkModel.forCreate({
    int? id,
    int? designId,
    required String nickname,
    String? customYarnInfo,
    String? customNeedleInfo,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? goalDate,
    XFile? file,
    String? title,
    String? designer,
    bool visible = false,
  }) {
    return WorkModel(
      designId: designId,
      nickname: nickname,
      customYarnInfo: customYarnInfo,
      customNeedleInfo: customNeedleInfo,
      startDate: startDate,
      endDate: endDate,
      goalDate: goalDate,
      file: file,

      id: id,
      designDto: null,
      userId: null,
      status: null,
      lastRecordAt: null,
      createdAt: null,
      image: null,

      title: title,
      designer: designer,
      visible: visible,
    );
  }

  WorkModel copyWith({
    int? id,
    DesignModel? designDto,
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
    ImageModel? image,
    XFile? file,
    String? title,
    String? designer,
    bool? visible,
  }) {
    return WorkModel(
      id: id ?? this.id,
      designDto: designDto ?? this.designDto,
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
      image: image ?? this.image,
      file: file ?? this.file,
      title: title ?? this.title,
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
        'designId': designId,
        'nickname': nickname,
        'customYarnInfo': customYarnInfo,
        'customNeedleInfo': customNeedleInfo,
        'startDate': startDate != null ? DateUtilsHelper.toHyphenFormat(startDate!) : null,
        'endDate': endDate != null ? DateUtilsHelper.toHyphenFormat(endDate!) : null,
        'goalDate': goalDate != null ? DateUtilsHelper.toHyphenFormat(goalDate!) : null,
        'title': title,
        'designer': designer,
        'visible': false,
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