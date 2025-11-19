import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:knittda/src/data/data_sources/feed_api.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/data/repository/feed_api_repository_impl.dart';
import 'package:knittda/src/domain/model/feed.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'feed_api_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  test('feed 데이터를 잘 가져와야 한다', () async {
    final dio = MockDio();

    final api = FeedApiRepositoryImpl(FeedApi(dio));

    when(dio.get(any, queryParameters: anyNamed('queryParameters'))).thenAnswer(
      (_) async => Response(
        data: jsonDecode(fakeJsonBody),
        statusCode: 200,
        requestOptions: RequestOptions(path: "/api/v1/feed/"),
      ),
    );

    final Result<List<Feed>> result = await api.getFeed(0, 10, null);

    expect((result as Success<List<Feed>>).data.first.userName, '');

    verify(dio.get("/api/v1/feed/", queryParameters: {'page': 0, 'size': 10}));
  });
}

String fakeJsonBody = """

""";
