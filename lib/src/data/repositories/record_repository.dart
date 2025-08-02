import 'package:dio/dio.dart';
import 'package:knittda/src/data/models/record_model.dart';

class RecordRepository {
  final Dio _dio;

  RecordRepository(this._dio);

  Future<RecordModel> getRecord(int recordId) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/api/v1/records/$recordId',
    );

    if (res.statusCode != 200) {
      throw Exception('서버 오류: ${res.statusCode}');
    }

    //debugPrint('기록 상세 조회 서버 응답: ${res.data}');

    final body = res.data;
    if (body == null || body['success'] != true) {
      throw Exception(body?['message'] ?? '알 수 없는 오류');
    }

    final data = body['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('잘못된 응답 형식');
    }

    return RecordModel.fromJson(data);
  }

  Future<List<RecordModel>> getRecords(int projectId) async{
    final res = await _dio.get<Map<String, dynamic>>(
      '/api/v1/records/projects/$projectId',
    );

    if (res.statusCode != 200) {
      throw Exception('서버 오류: ${res.statusCode}');
    }

    //debugPrint('프로젝트별 기록 조회 서버 응답: ${res.data}');

    final body = res.data;
    if (body == null || body['success'] != true) {
      throw Exception(body?['message'] ?? '알 수 없는 오류');
    }

    final data = body['data'] as List<dynamic>?;
    if (data == null) {
      throw Exception('잘못된 응답 형식');
    }

    return data.map((e) => RecordModel.fromJson(e)).toList();
  }

  Future<RecordModel> createRecord(RecordModel record) async {
    final formData = await record.toMultipartForm();

    // debugPrint('보낸 내용: ${formData.fields}, 파일 개수: ${formData.files.length}');
    // for (final file in formData.files) {
    //   debugPrint('📸 file: ${file.key} → ${file.value.filename}');
    // }
    // debugPrint('formData runtimeType: ${formData.runtimeType}');

    final res = await _dio.post<Map<String, dynamic>>(
      '/api/v1/records/',
      data: formData,
    );

    if (res.statusCode != 200) {
      throw Exception('서버 오류: ${res.statusCode}');
    }

    //debugPrint('기록 생성 서버 응답: ${res.data}');
    final body = res.data;
    if (body == null || body['success'] != true) {
      throw Exception(body?['message'] ?? '알 수 없는 오류');
    }

    final data = body['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('잘못된 응답 형식');
    }

    return RecordModel.fromJson(data);
  }

  //record 수정
  Future<RecordModel> updateRecord(RecordModel record, List<int>? deleteImageIds) async {
    final formData = await record.toEditMultipartForm(
      deleteImageIds: deleteImageIds,
    );

    // formData 확인
    // for (final field in formData.fields) {
    //   debugPrint('field: ${field.key} = ${field.value} (type: ${field.value.runtimeType})');
    // }

    final res = await _dio.put<Map<String, dynamic>>(
      '/api/v1/records/',
      data: formData,
    );

    if (res.statusCode != 200) {
      throw Exception('서버 오류: ${res.statusCode}');
    }

    //debugPrint('기록 수정 서버 응답: ${res.data}');

    final body = res.data;
    if (body == null || body['success'] != true) {
      throw Exception(body?['message'] ?? '알 수 없는 오류');
    }

    final data = body['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('잘못된 응답 형식');
    }

    return RecordModel.fromJson(data);
  }

  Future<void> deleteRecord(int recordId) async{
    final res = await _dio.delete<Map<String, dynamic>>(
      '/api/v1/records/$recordId',
    );

    if (res.statusCode != 200) {
      throw Exception('서버 오류: ${res.statusCode}');
    }

    //debugPrint('기록 삭제 서버 응답: ${res.data}');

    final body = res.data;
    if (body == null || body['success'] != true) {
      throw Exception(body?['message'] ?? '알 수 없는 오류');
    }
  }

  Future<String> getQuestion(int projectId) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/api/v1/questions/generate/$projectId',
    );

    if (res.statusCode != 200) {
      throw Exception('서버 오류: ${res.statusCode}');
    }

    final body = res.data;
    if (body == null || body['success'] != true) {
      throw Exception(body?['message'] ?? '알 수 없는 오류');
    }

    final question = body['data'];
    if (question is! String || question.trim().isEmpty) {
      throw Exception('질문 형식이 잘못되었거나 비어 있습니다.');
    }

    return question;
  }

}

