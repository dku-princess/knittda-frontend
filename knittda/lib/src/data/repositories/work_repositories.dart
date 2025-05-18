import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/work_model.dart';

class WorkRepositories {
  static final baseUrl = 'http://13.125.122.193:8080/';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json',
    ),
  );

  Future<({WorkModel work})> updateWork(String accessToken, WorkModel work) async {
    try {
      final formData =  await work.toMultipartForm();

      // debugPrint('=== [작품 수정 요청 FormData] ===');
      // for (final field in formData.fields) {
      //   debugPrint('field: ${field.key} = ${field.value}');
      // }
      // for (final file in formData.files) {
      //   debugPrint('file: ${file.key} → ${file.value.filename}');
      // }
      // debugPrint('=============================');

      final res = await _dio.put<Map<String, dynamic>>(
        '/api/v1/projects/',
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

      final responseBody = res.data;

      if (responseBody == null || responseBody['success'] != true) {
        throw Exception(responseBody?['message'] ?? '알 수 없는 오류');
      }

      final data = responseBody['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('잘못된 응답 형식');
      }

      final updateWork = WorkModel.fromJson(data);
      return (work: updateWork);

    } on DioException catch (e) {
      debugPrint('네트워크 오류: ${e.response?.data ?? e.message}');
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      debugPrint('작품 수정 중 예외: $e');
      throw Exception('작품 수정 중 오류: $e');
    }
  }


  //서버에서 작품 삭제하기
  Future<void> deleteWork(String accessToken, int projectId) async {
    try{
      final res = await _dio.delete<Map<String, dynamic>>(
        '/api/v1/projects/$projectId',
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

      final body = res.data;
      if (body == null || body['success'] != true) {
        throw Exception(body?['message'] ?? '알 수 없는 오류');
      }

    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('작품 생성하기 중 오류: $e');
    }
  }
  //서버에서 작품 단건 조회하기
  Future<({WorkModel work})> getWork(String accessToken, int projectId) async {
    try{
      final res = await _dio.get<Map<String, dynamic>>(
        '/api/v1/projects/$projectId',
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

      final body = res.data;
      if (body == null || body['success'] != true) {
        throw Exception(body?['message'] ?? '알 수 없는 오류');
      }

      final data = body['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('잘못된 응답 형식');
      }

      return (work: WorkModel.fromJson(data));

    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('작품 생성하기 중 오류: $e');
    }
  }

  //서버에서 작품 목록 가져오기
  Future<List<WorkModel>> getWorks(String accessToken) async{
    try{
      final res = await _dio.get<Map<String, dynamic>>(
        '/api/v1/projects/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (res.statusCode != 200) {
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

      return data.map((item) => WorkModel.fromJson(item as Map<String, dynamic>)).toList();

    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('작품 조회하기 중 오류: $e');
    }
  }

  //작품 생성하기
  Future<({WorkModel work})> createWork(String accessToken, WorkModel work) async {
    try {
      final formData =  await work.toMultipartForm();

      final res = await _dio.post<Map<String, dynamic>>(
        '/api/v1/projects/',
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

      final responseBody = res.data;

      if (responseBody == null || responseBody['success'] != true) {
        throw Exception(responseBody?['message'] ?? '알 수 없는 오류');
      }

      final data = responseBody['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('잘못된 응답 형식');
      }

      final createdWork = WorkModel.fromJson(data);
      return (work: createdWork);

    } on DioException catch (e) {
      debugPrint('네트워크 오류: ${e.response?.data ?? e.message}');
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      debugPrint('작품 생성 중 예외: $e');
      throw Exception('작품 생성 중 오류: $e');
    }
  }
}