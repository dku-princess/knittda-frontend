import 'package:knittda/src/data/data_sources/feed_api.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/feed_pagination.dart';
import 'package:knittda/src/domain/repository/feed_api_repository.dart';

class FeedApiRepositoryImpl implements FeedApiRepository {
  final FeedApi _api;
  FeedApiRepositoryImpl(this._api);

  @override
  Future<Result<FeedPagination>> getFeed(
    int page,
    int size,
    List<String>? sort,
  ) async {
    final Result<Map<String, dynamic>> result = await _api.getFeed(
      page,
      size,
      sort,
    );

    return switch (result) {
      Success(:final data) => Result.success(FeedPagination.fromJson(data)),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<Result<FeedPagination>> getSearchFeed(
    String keyword,
    int page,
    int size,
    List<String>? sort,
  ) async {
    final Result<Map<String, dynamic>> result = await _api.getSearchFeed(
      keyword,
      page,
      size,
      sort,
    );

    switch (result) {
      case Success(:final data):
        try {
          print('[FeedApiRepository] Parsing search response:');
          print('  - data keys: ${data.keys}');
          print('  - content: ${data['content']?.length ?? 0} items');
          print('  - searchId: ${data['searchId']}');
          print('  - searchVersion: ${data['searchVersion']}');
          
          // 첫 번째 content 항목의 구조 확인
          if (data['content'] != null && (data['content'] as List).isNotEmpty) {
            final firstItem = (data['content'] as List).first;
            print('  - First content item keys: ${(firstItem as Map).keys}');
            if (firstItem['record'] != null) {
              print('  - First record keys: ${(firstItem['record'] as Map).keys}');
              print('  - First record.id: ${firstItem['record']['id']}');
              print('  - First record.recordId: ${firstItem['record']['recordId']}');
            }
          }
          
          final pagination = FeedPagination.fromJson(data);
          print('[FeedApiRepository] Parsed successfully:');
          print('  - content length: ${pagination.content.length}');
          print('  - searchId: ${pagination.searchId}');
          print('  - searchVersion: ${pagination.searchVersion}');
          
          // 파싱된 첫 번째 feed의 record 정보
          if (pagination.content.isNotEmpty) {
            final firstFeed = pagination.content.first;
            print('  - First feed record.id: ${firstFeed.record.id}');
            print('  - First feed record.recordId: ${firstFeed.record.recordId}');
          }
          
          return Result.success(pagination);
        } catch (e, stack) {
          print('[FeedApiRepository] JSON parsing error: $e');
          print('  - Stack: $stack');
          print('  - Data: $data');
          return Result.error('응답 파싱 오류: $e');
        }
      case Error(:final e):
        return Result.error(e);
    }
  }

  @override
  Future<Result<void>> postSearchClickLog({
    required String searchId,
    required String keyword,
    required int recordId,
    required int rank,
    required int page,
  }) async {
    final result = await _api.postSearchClickLog(
      searchId: searchId,
      keyword: keyword,
      recordId: recordId,
      rank: rank,
      page: page,
    );

    return switch (result) {
      Success() => Result.success(null),
      Error(:final e) => Result.error(e),
    };
  }
}
