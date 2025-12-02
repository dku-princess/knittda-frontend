import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/feed_pagination.dart';
import 'package:knittda/src/domain/repository/feed_api_repository.dart';

class GetSearchFeedUseCase {
  final FeedApiRepository _repository;

  GetSearchFeedUseCase(this._repository);

  Future<Result<FeedPagination>> call(
    String keyword,
    int page,
    int size,
    List<String>? sort,
  ) async {
    final result = await _repository.getSearchFeed(keyword, page, size, sort);
    return switch (result) {
      // Success(:final data) => Result.success(data),
      // Error(:final e) => Result.error(e),
      Success<FeedPagination>() => Result.success(result.data),
      Error<FeedPagination>() => Result.error(result.e),
    };
  }
}
