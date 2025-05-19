import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';


class RecordsRepository {
  static final baseUrl = 'http://13.125.122.193:8080/';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
    ),
  );

  //record 수정
  Future<({RecordModel record})> updateRecord(String accessToken, RecordModel record, List<int>? deleteImageIds) async {
    try{
      final formData = await record.toEditMultipartForm(
        deleteImageIds: deleteImageIds,
      );

      // 🔍 formData 확인
      for (final field in formData.fields) {
        debugPrint('📦 field: ${field.key} = ${field.value} (type: ${field.value.runtimeType})');
      }

      final res = await _dio.put<Map<String, dynamic>>(
        '/api/v1/records/',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (res.statusCode != 200) {
        throw Exception('서버 오류: ${res.statusCode}');
      }

      debugPrint('서버 응답: ${res.data}');

      final body = res.data;
      if (body == null || body['success'] != true) {
        throw Exception(body?['message'] ?? '알 수 없는 오류');
      }

      final data = body['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('잘못된 응답 형식');
      }

      return (record: RecordModel.fromJson(data));

    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('기록 수정 중 오류: $e');
    }
  }

  //record 상세 조회
  Future<({RecordModel record})> getRecord(String accessToken, int recordId) async {
    try{
      final res = await _dio.get<Map<String, dynamic>>(
        '/api/v1/records/$recordId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'projectId': '$recordId'
          },
        ),
      );

      if (res.statusCode != 200) {
        throw Exception('서버 오류: ${res.statusCode}');
      }

      debugPrint('서버 응답: ${res.data}');

      final body = res.data;
      if (body == null || body['success'] != true) {
        throw Exception(body?['message'] ?? '알 수 없는 오류');
      }

      final data = body['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('잘못된 응답 형식');
      }

      return (record: RecordModel.fromJson(data));

    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('작품 생성하기 중 오류: $e');
    }
  }

  //프로젝트별 record 조회
  Future<List<RecordModel>> getRecords(String accessToken, int projectId) async{
    try{
      final res = await _dio.get<Map<String, dynamic>>(
        '/api/v1/records/projects/$projectId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'projectId': '$projectId'
          },
        ),
      );

      if (res.statusCode != 200) {
        throw Exception('서버 오류: ${res.statusCode}');
      }

      debugPrint('서버 응답: ${res.data}');

      final body = res.data;
      if (body == null || body['success'] != true) {
        throw Exception(body?['message'] ?? '알 수 없는 오류');
      }

      final data = body['data'] as List<dynamic>?;
      if (data == null) {
        throw Exception('잘못된 응답 형식');
      }

      return data.map((item) => RecordModel.fromJson(item as Map<String, dynamic>)).toList();

    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('작품 조회하기 중 오류: $e');
    }
  }

  Future<({RecordModel record})> createRecord(String accessToken, RecordModel record) async {
    try {
      final formData = await record.toMultipartForm();

      //final recordJson = record.toJson();

      debugPrint('보낸 내용: ${formData.fields}, 파일 개수: ${formData.files.length}');
      for (final file in formData.files) {
        debugPrint('📸 file: ${file.key} → ${file.value.filename}');
      }
      debugPrint('formData runtimeType: ${formData.runtimeType}');
      //debugPrint('보낸 내용: ${jsonEncode(recordJson)}');

      final res = await _dio.post<Map<String, dynamic>>(
        '/api/v1/records/',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            //'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (res.statusCode != 200) {
        throw Exception('서버 오류: ${res.statusCode}');
      }

      final responseBody = res.data;
      debugPrint('서버 응답: $responseBody');

      if (responseBody == null || responseBody['success'] != true) {
        throw Exception(responseBody?['message'] ?? '알 수 없는 오류');
      }

      final data = responseBody['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('잘못된 응답 형식');
      }

      final createRecord = RecordModel.fromJson(data);
      return (record: createRecord);

    } on DioException catch (e) {
      debugPrint('네트워크 오류: ${e.response?.data ?? e.message}');
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      debugPrint('기록 생성 중 예외: $e');
      throw Exception('기록 생성 중 오류: $e');
    }
  }

  Future<void> deleteRecord(String accessToken, int recordId) async{
    try{
      final res = await _dio.delete<Map<String, dynamic>>(
        '/api/v1/records/$recordId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'recordId': '$recordId'
          },
        ),
      );

      if (res.statusCode != 200) {
        throw Exception('서버 오류: ${res.statusCode}');
      }

      debugPrint('서버 응답: ${res.data}');

      final body = res.data;
      if (body == null || body['success'] != true) {
        throw Exception(body?['message'] ?? '알 수 없는 오류');
      }

    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('기록 삭제 중 오류: $e');
    }
  }
}

