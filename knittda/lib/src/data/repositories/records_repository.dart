import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/models/records_model.dart';
import 'package:path/path.dart' as path;


class RecordsRepository {
  static final baseUrl = 'http://13.125.122.193:8080/';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
    ),
  );

  Future<({RecordsModel record})> createRecord(
      String accessToken,
      RecordsModel record,
      ) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '/api/v1/records/',
        data: record.toJson(includeFiles: false),
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
          contentType: Headers.jsonContentType,
        ),
      );

      if (res.statusCode != 200) {
        // 🔽 서버가 내려주는 메시지를 그대로 로그에 찍기
        debugPrint('STATUS  : ${res.statusCode}');
        debugPrint('RESPONSE: ${res.data}');
        throw Exception(res.data?['message'] ?? 'status ${res.statusCode}');
      }

      return (record: RecordsModel.fromJson(res.data!['data']));
    } on DioException catch (e) {
      debugPrint('REQUEST BODY: ${jsonEncode(record.toJson(includeFiles: false))}');
      debugPrint('ERROR BODY  : ${e.response?.data}');
      rethrow;
    }
  }
}

