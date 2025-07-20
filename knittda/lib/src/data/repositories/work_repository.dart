import 'package:dio/dio.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/data/models/work_preview_model.dart';

class WorkRepository {
  final Dio _dio;

  WorkRepository(this._dio);

  Future<WorkModel> getWork(int projectId) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/api/v1/projects/$projectId',
    );

    if (res.statusCode != 200) {
      throw Exception('서버 오류: ${res.statusCode}');
    }

    //debugPrint('작품 상세 조회 서버 응답: ${res.data}');

    final body = res.data;
    if (body == null || body['success'] != true) {
      throw Exception(body?['message'] ?? '알 수 없는 오류');
    }

    final data = body['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('잘못된 응답 형식');
    }

    return WorkModel.fromJson(data);
  }

  Future<List<WorkModel>> getWorks() async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/api/v1/projects/',
    );

    if (res.statusCode != 200) {
      throw Exception('서버 오류: ${res.statusCode}');
    }

    //debugPrint('작품 목록 서버 응답: ${res.data}');

    final body = res.data;
    if (body == null || body['success'] != true) {
      throw Exception(body?['message'] ?? '알 수 없는 오류');
    }

    final data = body['data'] as List<dynamic>?;
    if (data == null) {
      throw Exception('잘못된 응답 형식');
    }

    return data.map((e) => WorkModel.fromJson(e)).toList();
  }

  Future<WorkModel> createWork(WorkModel work) async {
    final formData =  await work.toMultipartForm();

    final res = await _dio.post<Map<String, dynamic>>(
      '/api/v1/projects/',
      data: formData,
    );

    if (res.statusCode != 200) {
      throw Exception('서버 오류: ${res.statusCode}');
    }

    //debugPrint('작품 생성 서버 응답: ${res.data}');

    final body = res.data;
    if (body == null || body['success'] != true) {
      throw Exception(body?['message'] ?? '알 수 없는 오류');
    }

    final data = body['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('잘못된 응답 형식');
    }

    return WorkModel.fromJson(data);
  }

  Future<WorkModel> updateWork(WorkModel work) async {
    final formData =  await work.toMultipartForm();

    // debugPrint('=== [작품 수정 요청 FormData] ===');
    // for (final field in formData.fields) {
    //   debugPrint('field: ${field.key} = ${field.value}');
    // }
    //
    // for (final file in formData.files) {
    //   debugPrint('file: ${file.key} → ${file.value.filename}');
    // }
    // debugPrint('=============================');

    final res = await _dio.put<Map<String, dynamic>>(
      '/api/v1/projects/',
      data: formData,
    );

    if (res.statusCode != 200) {
      throw Exception('서버 오류: ${res.statusCode}');
    }

    //debugPrint('작품 수정 서버 응답: ${res.data}');

    final body = res.data;
    if (body == null || body['success'] != true) {
      throw Exception(body?['message'] ?? '알 수 없는 오류');
    }

    final data = body['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('잘못된 응답 형식');
    }

    return WorkModel.fromJson(data);
  }


  //서버에서 작품 삭제하기
  Future<void> deleteWork(int projectId) async {
    final res = await _dio.delete<Map<String, dynamic>>(
      '/api/v1/projects/$projectId',
    );

    if (res.statusCode != 200) {
      throw Exception('서버 오류: ${res.statusCode}');
    }

    //debugPrint('작품 삭제 서버 응답: ${res.data}');

    final body = res.data;
    if (body == null || body['success'] != true) {
      throw Exception(body?['message'] ?? '알 수 없는 오류');
    }
  }

  Future<List<WorkPreviewModel>> getWorkPreviews() async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/api/v1/projects/previews',
    );

    if (res.statusCode != 200){
      throw Exception('서버 오류: ${res.statusCode}');
    }

    final body = res.data;
    if (body == null || body['success'] != true) {
      throw Exception(body?['message'] ?? '알 수 없는 오류');
    }

    final data = body['data'] as List<dynamic>?;
    if (data == null) {
      throw Exception('잘못된 응답 형식');
    }

    return data.map((e) => WorkPreviewModel.fromJson(e)).toList();
  }

}