import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/models/image_model.dart';
import 'package:knittda/src/data/models/work_model.dart';

class RecordsModel {
  final int projectId;
  final String recordStatus;
  final List<String> tags;
  final String comment;
  final DateTime? recordedAt;
  final List<String>? files;

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

  Map<String, dynamic> toJson({bool includeFiles = true}) => {
    'record': {
      'projectId'   : projectId,
      'recordStatus': recordStatus,
      'tags'        : tags,
      'comment'     : comment,
      'recordedAt'  : recordedAt?.toIso8601String() ??
          DateTime.now().toIso8601String(),
    },
    if (includeFiles && files != null && files!.isNotEmpty)
      'files': files,
  };

  factory RecordsModel.forCreate({
    required int projectId,
    required String recordStatus,
    required List<String> tags,
    required String comment,
    DateTime? recordedAt,
    List<String>? files,
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
    List<String>? files,
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
