import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/models/image_model.dart';
import 'package:knittda/src/data/models/work_model.dart';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class RecordModel {
  final int projectId;
  final String? recordStatus;

  //null 가능한 값
  final List<String>? tags;
  final String? comment;

  //서버 응답에는 없는 값
  final List<XFile>? files;

  //서버가 보내는 값
  final int? id;
  final WorkModel? projectDto;
  final DateTime? createdAt;
  final List<ImageModel>? images;

  RecordModel({
    required this.projectId,
    this.recordStatus,
    this.tags,
    this.comment,
    this.files,
    this.id,
    this.projectDto,
    this.createdAt,
    this.images,
  });

  factory RecordModel.fromJson(Map<String, dynamic> json) {
    return RecordModel(
      projectId: json['projectDto']['id'],
      recordStatus: json['recordStatus'],

      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList(),
      comment: json['comment'],

      files: null,

      id: json['id'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      projectDto: json['projectDto'] != null
          ? WorkModel.fromJson(json['projectDto'])
          : null,
      images: (json['images'] as List?)
          ?.where((e) => e != null)
          .map((e) => ImageModel.fromJson(e))
          .toList(),
    );
  }

  factory RecordModel.forCreate({
    required int projectId,
    String? recordStatus,
    List<String>? tags,
    String? comment,
    List<XFile>? files,

    int? id
  }) {
    return RecordModel(
      projectId: projectId,
      recordStatus: recordStatus,
      tags: tags,
      comment: comment,
      files: files,

      // 서버 응답 필드 → null로 초기화
      id: id,
      projectDto: null,
      createdAt: null,
      images: null,
    );
  }

  RecordModel copyWith({
    int? projectId,
    String? recordStatus,
    List<String>? tags,
    String? comment,
    List<XFile>? files,
    int? id,
    WorkModel? projectDto,
    DateTime? createdAt,
    List<ImageModel>? images,
  }) {
    return RecordModel(
      projectId: projectId ?? this.projectId,
      recordStatus: recordStatus ?? this.recordStatus,
      tags: tags ?? this.tags,
      comment: comment ?? this.comment,
      files: files ?? this.files,
      id: id ?? this.id,
      projectDto: projectDto ?? this.projectDto,
      createdAt: createdAt ?? this.createdAt,
      images: images ?? this.images,
    );
  }
}

extension RecordModelMultipart on RecordModel {
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

  Future<FormData> toEditMultipartForm({List<int>? deleteImageIds}) async {
    final form = FormData();

    final recordJson = jsonEncode({
      'recordId': id,
      'recordStatus': recordStatus,
      'tags': tags,
      'comment': comment,
    });

    form.fields.add(MapEntry('record', recordJson));
    //debugPrint('📦 record = $recordJson (type: ${recordJson.runtimeType})');

    if (deleteImageIds != null && deleteImageIds.isNotEmpty) {
      final deleteImageIdsJson = jsonEncode(deleteImageIds);
      form.fields.add(MapEntry('deleteImageIds', deleteImageIdsJson));
      //debugPrint('🧪 deleteImageIds = $deleteImageIdsJson (type: ${deleteImageIdsJson.runtimeType})');
    }

    // 3️⃣ 파일 추가
    if (files != null && files!.isNotEmpty) {
      for (final file in files!) {
        final multipart = await MultipartFile.fromFile(
          file.path,
          filename: file.name,
          contentType: MediaType('image', 'jpeg'),
        );

        form.files.add(MapEntry('files', multipart));
        //debugPrint('📷 file = ${file.name} (${file.path})');
      }
    }

    return form;
  }
}

