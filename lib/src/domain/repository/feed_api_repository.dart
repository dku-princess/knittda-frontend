import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/feed.dart';

abstract class FeedApiRepository {
  Future<Result<List<Feed>>> getFeed(int page, int size, List<String>? sort);
}
