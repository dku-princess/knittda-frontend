import 'dart:convert';

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

      debugPrint('서버 응답: ${res.data}');

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

  Future<({WorkModel work})> createWork(String accessToken, WorkModel work) async{
    try{
      final json = work.toCreateJson();

      debugPrint('Authorization: Bearer $accessToken');
      debugPrint('보낸 내용${jsonEncode(json)}');

      final res = await _dio.post<Map<String, dynamic>>(
        '/api/v1/projects/',
        data: json,
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

      return (work: WorkModel.fromJson(data));

    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('작품 생성하기 중 오류: $e');
    }
  }
}