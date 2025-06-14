import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/models/report_model.dart';
import 'package:knittda/env.dart';

import '../../core/storage/report_local_data_source.dart';

class ReportRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json',
    ),
  );

  final ReportLocalDataSource _local = ReportLocalDataSource();

  Future<ReportModel> fetchReportFromServer (String accessToken) async {
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

      return ReportModel.fromJson(data);

    } on DioException catch (e) {
      debugPrint('네트워크 오류: ${e.response?.data ?? e.message}');
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      debugPrint('리포트 불러오기 예외: $e');
      throw Exception('리포트 불러오기 오류: $e');
    }
  }

  Future<ReportModel> getReport(String token, {bool forceRefresh = false}) async {
    final weekId = DateUtilsHelper.getCurrentWeekId();

    if (!forceRefresh) {
      final cached = await _local.load(weekId);
      if (cached != null) return cached;
    }

    // // 로컬 캐시 확인
    // final cached = await _local.load(weekId);
    // if (cached != null) return cached;

    // 캐시 없으면 서버 호출
    final fresh = await fetchReportFromServer(token);

    // 받아온 결과를 캐시에 저장
    await _local.save(weekId, fresh);
    return fresh;
  }
}