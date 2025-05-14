import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/models/image_model.dart';
import 'package:knittda/src/data/models/work_model.dart';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class RecordsModel {
  final int projectId;
  final String recordStatus;
  final List<String> tags;
  final String comment;
  final DateTime? recordedAt;
  final List<XFile>? files;

  final int? id;
  final WorkModel? projectDto;
  final DateTime? createdAt;
  final List<ImageModel>? images;

  RecordsModel({
    required this.projectId,
    required this.recordStatus,
    required this.tags,
    required this.comment,
    this.recordedAt,
    this.files,
    this.id,
    this.projectDto,
    this.createdAt,
    this.images,
  });

  factory RecordsModel.fromJson(Map<String, dynamic> json) {
    return RecordsModel(
      projectId: json['projectDto']['id'],
      recordStatus: json['recordStatus'] ?? '',
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      comment: json['comment'] ?? '',
      recordedAt: null, // 응답에는 없음
      files: null, // 응답에는 없음
      id: json['id'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      projectDto: json['projectDto'] != null ? WorkModel.fromJson(json['projectDto']) : null,
      images: (json['images'] as List?)?.map((e) => ImageModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'record': {
      'projectId'   : projectId,
      'recordStatus': recordStatus,
      'tags'        : tags,
      'comment'     : comment,
      'recordedAt'  : recordedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    },
    'files': files ?? [],
  };

  factory RecordsModel.forCreate({
    required int projectId,
    required String recordStatus,
    required List<String> tags,
    required String comment,
    DateTime? recordedAt,
    List<XFile>? files,
  }) {
    return RecordsModel(
      projectId: projectId,
      recordStatus: recordStatus,
      tags: tags,
      comment: comment,
      recordedAt: recordedAt,
      files: files,

      // 서버 응답 필드 → null로 초기화
      id: null,
      projectDto: null,
      createdAt: null,
      images: null,
    );
  }

  RecordsModel copyWith({
    int? projectId,
    String? recordStatus,
    List<String>? tags,
    String? comment,
    DateTime? recordedAt,
    List<XFile>? files,
    int? id,
    WorkModel? projectDto,
    DateTime? createdAt,
    List<ImageModel>? images,
  }) {
    return RecordsModel(
      projectId: projectId ?? this.projectId,
      recordStatus: recordStatus ?? this.recordStatus,
      tags: tags ?? this.tags,
      comment: comment ?? this.comment,
      recordedAt: recordedAt ?? this.recordedAt,
      files: files ?? this.files,
      id: id ?? this.id,
      projectDto: projectDto ?? this.projectDto,
      createdAt: createdAt ?? this.createdAt,
      images: images ?? this.images,
    );
  }
}

extension RecordsModelMultipart on RecordsModel {
  Future<FormData> toMultipartForm() async {
    final form = FormData();

    // record는 JSON 형태의 문자열로 필드에 넣음
    form.fields.add(MapEntry(
      'record',
      jsonEncode({
        'projectId'   : projectId,
        'recordStatus': recordStatus,
        'tags'        : tags,
        'comment'     : comment,
        'recordedAt'  : recordedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      }),
    ));

    // 파일 추가
    if (files != null && files!.isNotEmpty) {
      for (final file in files!) {
        form.files.add(MapEntry(
          'files',
          await MultipartFile.fromFile(
            file.path,
            filename: file.name,
            contentType: MediaType('image', 'jpeg'), // 필요 시 이미지 타입 감지 라이브러리 사용 가능
          ),
        ));
      }
    }
    return form;
  }
}