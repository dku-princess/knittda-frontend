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
          final pagination = FeedPagination.fromJson(data);

          return Result.success(pagination);
        } catch (e) {
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
