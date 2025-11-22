import 'package:flutter_test/flutter_test.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/feed_pagination.dart';
import 'package:knittda/src/domain/repository/feed_api_repository.dart';
import 'package:knittda/src/domain/use_case/get_feed_use_case.dart';
import 'package:knittda/src/presentation/feed/feed_event.dart';
import 'package:knittda/src/presentation/feed/feed_view_model.dart';

void main() {
  test('vm이 잘 동작해야 한다', () async {
    final viewModel = FeedViewModel(GetFeedUseCase(FakeFeedApiRepository()));

    await viewModel.onEvent(FeedEvent.loadFeed(0,20,null));

    final FeedPagination result = FeedPagination.fromJson(fakeJson);

    expect(viewModel.state.feeds, equals(result.content));
  });
}

class FakeFeedApiRepository extends FeedApiRepository {
  @override
  Future<Result<FeedPagination>> getFeed(int page, int size, List<String>? sort) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return Result.success(FeedPagination.fromJson(fakeJson));
  }
}

Map<String, dynamic> fakeJson = {

};