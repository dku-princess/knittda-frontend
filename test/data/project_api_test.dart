import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:knittda/src/data/data_sources/project_api.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/data/repository/project_api_repository_impl.dart';
import 'package:knittda/src/domain/model/project_previews.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'project_api_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  test('project 데이터를 잘 가져와야 한다', () async {
    final dio = MockDio();

    final api = ProjectApiRepositoryImpl(ProjectApi(dio));

    when(dio.get("/api/v1/projects/previews")).thenAnswer(
      (_) async => Response(
        data: jsonDecode(fakeJsonBody),
        statusCode: 200,
        requestOptions: RequestOptions(),
      ),
    );

    final Result<List<ProjectPreviews>> result = await api.getProjectPreviews();

    expect(
      (result as Success<List<ProjectPreviews>>).data.first.userName,
      '',
    );

    verify(dio.get("/api/v1/projects/previews"));
  });
}

String fakeJsonBody = '';
