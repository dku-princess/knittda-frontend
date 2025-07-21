import 'package:knittda/src/data/models/feed_model.dart';
import 'package:knittda/src/data/repositories/feed_repository.dart';

class FeedService {
  final FeedRepository _repo;
  FeedService(this._repo);

  Future<List<FeedModel>> getFeeds({
    required int page,
    int size = 10,
    List<String>? sort,
  }) {
    return _repo.fetchFeeds(page: page, size: size, sort: sort);
  }

  Future<List<FeedModel>> searchFeeds({
    required String keyword,
    required int page,
    int size = 10,
    List<String>? sort,
  }) {
    return _repo.searchFeeds(
      keyword: keyword,
      page : page,
      size : size,
      sort : sort,
    );
  }

}