import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';

class RecordRepository extends ChangeNotifier{
  final Dio _dio;

  RecordRepository(this._dio);

  List<RecordModel> _records = [];
  RecordModel? _record;

  List<RecordModel> get records => List.unmodifiable(_records);
  RecordModel? get record => _record;

  //record 수정
  Future<void> updateRecord(RecordModel record, List<int>? deleteImageIds) async {
    try{
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

      debugPrint('기록 수정 서버 응답: ${res.data}');

      final body = res.data;
      if (body == null || body['success'] != true) {
        throw Exception(body?['message'] ?? '알 수 없는 오류');
      }

      final data = body['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('잘못된 응답 형식');
      }

      final updatedRecord = RecordModel.fromJson(data);

      final index = _records.indexWhere((w) => w.id ==updatedRecord.id);
      if(index != -1) {
        _records[index] = updatedRecord;
      } else {
        _records.add(updatedRecord);
      }

      _record = updatedRecord;
      notifyListeners();

    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('기록 수정 중 오류: $e');
    }
  }

  //record 상세 조회
  Future<void> getRecord(int recordId) async {
    try{
      final res = await _dio.get<Map<String, dynamic>>(
        '/api/v1/records/$recordId',
      );

      if (res.statusCode != 200) {
        throw Exception('서버 오류: ${res.statusCode}');
      }

      debugPrint('기록 상세 조회 서버 응답: ${res.data}');

      final body = res.data;
      if (body == null || body['success'] != true) {
        throw Exception(body?['message'] ?? '알 수 없는 오류');
      }

      final data = body['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('잘못된 응답 형식');
      }

      _record = RecordModel.fromJson(data);
      notifyListeners();

    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('작품 생성하기 중 오류: $e');
    }
  }

  //프로젝트별 record 조회
  Future<void> getRecords(int projectId) async{
    try{
      final res = await _dio.get<Map<String, dynamic>>(
        '/api/v1/records/projects/$projectId',
      );

      if (res.statusCode != 200) {
        throw Exception('서버 오류: ${res.statusCode}');
      }

      debugPrint('프로젝트별 기록 조회 서버 응답: ${res.data}');

      final body = res.data;
      if (body == null || body['success'] != true) {
        throw Exception(body?['message'] ?? '알 수 없는 오류');
      }

      final data = body['data'] as List<dynamic>?;
      if (data == null) {
        throw Exception('잘못된 응답 형식');
      }

      _records = data.map((e) => RecordModel.fromJson(e)).toList();
      notifyListeners();

    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('작품 조회하기 중 오류: $e');
    }
  }

  Future<void> createRecord(RecordModel record) async {
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
      );

      if (res.statusCode != 200) {
        throw Exception('서버 오류: ${res.statusCode}');
      }

      final responseBody = res.data;
      debugPrint('기록 생성 서버 응답: $responseBody');

      if (responseBody == null || responseBody['success'] != true) {
        throw Exception(responseBody?['message'] ?? '알 수 없는 오류');
      }

      final data = responseBody['data'] as Map<String, dynamic>?;
      if (data == null) {
        throw Exception('잘못된 응답 형식');
      }

      final createdRecord = RecordModel.fromJson(data);

      final exists = _records.any((w) => w.id ==createdRecord.id);
      if(!exists) {
        _records.add(createdRecord);
      }

      _record = createdRecord;
      notifyListeners();

    } on DioException catch (e) {
      debugPrint('네트워크 오류: ${e.response?.data ?? e.message}');
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      debugPrint('기록 생성 중 예외: $e');
      throw Exception('기록 생성 중 오류: $e');
    }
  }

  Future<void> deleteRecord(int recordId) async{
    try{
      final res = await _dio.delete<Map<String, dynamic>>(
        '/api/v1/records/$recordId',
      );

      if (res.statusCode != 200) {
        throw Exception('서버 오류: ${res.statusCode}');
      }

      debugPrint('기록 삭제 서버 응답: ${res.data}');

      final body = res.data;
      if (body == null || body['success'] != true) {
        throw Exception(body?['message'] ?? '알 수 없는 오류');
      }

      _records.removeWhere((w) => w.id == recordId);
      notifyListeners();

    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('기록 삭제 중 오류: $e');
    }
  }
}

