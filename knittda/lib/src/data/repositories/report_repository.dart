import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/report_model.dart';
import 'package:knittda/env.dart';

class ReportRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json',
    ),
  );

  Future<({ReportModel report})> getReport(String accessToken) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '/api/v1/report/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (res.statusCode != 200) {
        throw Exception('서버 오류: ${res.statusCode}');
      }

      debugPrint('리포트 서버 응답: ${res.data}');

      final body = res.data;

      if (body == null || body['success'] != true) {
        throw Exception(body?['message'] ?? '알 수 없는 오류');
      }

      final data = body['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('잘못된 응답 형식');
      }

      return (report: ReportModel.fromJson(data));

    } on DioException catch (e) {
      debugPrint('네트워크 오류: ${e.response?.data ?? e.message}');
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      debugPrint('리포트 불러오기 예외: $e');
      throw Exception('리포트 불러오기 오류: $e');
    }
  }
}