import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:knittda/env.dart';
import 'package:knittda/src/data/models/feed_model.dart';

class FeedRepository extends ChangeNotifier {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl, // baseUrl은 따로 선언되어 있다고 가정
    ),
  );

  List<FeedModel> _feeds = [];
  FeedModel? _feed;

  List<FeedModel> get feeds => List.unmodifiable(_feeds);
  FeedModel? get feed => _feed;

  /// 피드 목록 조회 (Pagination)
  Future<List<FeedModel>> fetchFeeds({
    required int page,
    required int size,
    List<String>? sort,
  }) async {
    try {
      final res = await _dio.get<Map<String, dynamic>>(
        '/api/v1/feed/',
        data: {
          "page": page,
          "size": size,
          "sort": sort ?? [],
        },
      );

      if (res.statusCode != 200) {
        throw Exception('서버 오류: ${res.statusCode}');
      }

      final data = res.data;
      if (data == null || data['data'] == null) {
        throw Exception('응답 데이터가 없습니다.');
      }

      final content = data['data']['content'];
      if (content == null || content is! List) {
        throw Exception('content가 없습니다.');
      }

      _feeds = content.map<FeedModel>((e) => FeedModel.fromJson(e)).toList();
      notifyListeners();
      return _feeds;
    } on DioException catch (e) {
      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('피드 조회 중 오류: $e');
    }
  }
}