import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/feed_pagination.dart';
import 'package:knittda/src/domain/repository/feed_api_repository.dart';

class GetFeedUseCase {
  final FeedApiRepository _repository;

  GetFeedUseCase(this._repository);

  Future<Result<FeedPagination>> call(
    int page,
    int size,
    List<String>? sort,
  ) async {
    final result = await _repository.getFeed(page, size, sort);
    return switch (result) {
      Success(:final data) => Result.success(data),
      Error(:final e) => Result.error(e),
    };
  }
}
