import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
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
  final int? userId;
  final String? status;
  final DateTime? lastRecordAt;
  final DateTime? createdAt;
  final ImageModel? image;

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
    this.userId,
    this.status,
    this.lastRecordAt,
    this.createdAt,
    this.image,
  });

  //서버에서 json 형식으로 돌려주면 map으로 저장
  factory WorkModel.fromJson(Map<String, dynamic> json) {
    return WorkModel(
      designId: json['designId'],
      nickname: json['nickname'],
      customYarnInfo: json['customYarnInfo'],
      customNeedleInfo: json['customNeedleInfo'],
      startDate:  json['startDate'] != null
          ? DateTime.tryParse(json['startDate'])
          : null,
      endDate:  json['endDate'] != null
          ? DateTime.tryParse(json['endDate'])
          : null,
      goalDate:  json['goalDate'] != null
          ? DateTime.tryParse(json['goalDate'])
          : null,
      file: null,

      id: json['id'],
      userId: json['userId'],
      status: json['status'],
      lastRecordAt: json['lastRecordAt'] != null
          ? DateTime.parse(json['lastRecordAt'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      image: json['image'] != null ? ImageModel.fromJson(json['image']) : null,
    );
  }

  // map으로 된 정보를 json으로 변형해서 서버로 전송
  Map<String, dynamic> toJson() {
    return {
      'project': {
        'designId': designId,
        'nickname': nickname,
        'customYarnInfo': customYarnInfo ?? '',
        'customNeedleInfo': customNeedleInfo ?? '',
        'startDate': startDate != null ? DateUtilsHelper.toHyphenFormat(startDate!) : null,
        'endDate': endDate != null ? DateUtilsHelper.toHyphenFormat(endDate!) : null,
        'goalDate': goalDate != null ? DateUtilsHelper.toHyphenFormat(goalDate!) : null,
      },
      'file': file?.path,
    };
  }

  /// 작품 생성 전용
  factory WorkModel.forCreate({
    int? designId,
    required String nickname,
    String? customYarnInfo,
    String? customNeedleInfo,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? goalDate,
    XFile? file,
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

      id: null,
      userId: null,
      status: null,
      lastRecordAt: null,
      createdAt: null,
      image: null,
    );
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
    ImageModel? image,
    XFile? file,
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
      image: image ?? this.image,
      file: file ?? this.file,
    );
  }
}

extension WorkModelMultipart on WorkModel {
  Future<FormData> toMultipartForm() async {
    final form = FormData();

    // JSON 문자열로 project 필드 추가
    form.fields.add(MapEntry(
      'project',
      jsonEncode({
        'designId'       : designId,
        'nickname'       : nickname,
        'customYarnInfo' : customYarnInfo ?? '',
        'customNeedleInfo': customNeedleInfo ?? '',
        'startDate'      : startDate != null ? DateUtilsHelper.toHyphenFormat(startDate!) : null,
        'endDate'        : endDate != null ? DateUtilsHelper.toHyphenFormat(endDate!) : null,
        'goalDate'       : goalDate != null ? DateUtilsHelper.toHyphenFormat(goalDate!) : null,
      }),
    ));

    // 이미지 파일 첨부 (선택)
    if (file != null) {
      form.files.add(MapEntry(
        'file',
        await MultipartFile.fromFile(
          file!.path,
          filename: file!.name,
          contentType: MediaType('image', 'jpeg'), // 필요 시 mime 자동화 가능
        ),
      ));
    }

    return form;
  }
}