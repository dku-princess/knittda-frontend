import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/feed_pagination.dart';

abstract class FeedApiRepository {
  Future<Result<FeedPagination>> getFeed(int page, int size, List<String>? sort);
}
