//import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/design_model.dart';

class DesignRepositories {
  static final baseUrl = 'http://13.125.122.193:8080/';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json',
    ),
  );

  //서버에서 도안 검색 결과 가져오기
  Future<List<DesignModel>> searchDesign(String keyword) async{
    try{
      final res = await _dio.get<Map<String, dynamic>>(
        '/v1/designs/search?keyword=$keyword',
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

      return data.map((item) => DesignModel.fromJson(item as Map<String, dynamic>)).toList();

    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('작품 조회하기 중 오류: $e');
    }
  }
}