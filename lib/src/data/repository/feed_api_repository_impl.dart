import 'package:knittda/src/data/data_sources/feed_api.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/feed.dart';
import 'package:knittda/src/domain/repository/feed_api_repository.dart';

class FeedApiRepositoryImpl implements FeedApiRepository {
  final FeedApi _api;
  FeedApiRepositoryImpl(this._api);

  @override
  Future<Result<List<Feed>>> getFeed(
    int page,
    int size,
    List<String>? sort,
  ) async {
    final Result<Iterable> result = await _api.getFeed(page, size, sort);

    return switch (result) {
      Success(:final data) => Result.success(
        data.map((e) => Feed.fromJson(e)).toList(),
      ),
      Error(:final e) => Result.error(e),
    };
  }
}
