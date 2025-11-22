import 'dart:io';
import 'package:dio/dio.dart';
import 'package:knittda/env.dart';
import 'package:knittda/src/core/storage/token_storage.dart';
import 'package:knittda/src/data/data_sources/feed_api.dart';
import 'package:knittda/src/data/data_sources/kakao_login.dart';
import 'package:knittda/src/data/data_sources/project_api.dart';
import 'package:knittda/src/data/data_sources/social_login_apple.dart';
import 'package:knittda/src/data/repositories/auth_repository.dart';
//import 'package:knittda/src/data/repositories/feed_repository.dart';
import 'package:knittda/src/data/repository/feed_api_repository_impl.dart';
import 'package:knittda/src/data/repository/project_api_repository_impl.dart';
import 'package:knittda/src/data/repositories/record_repository.dart';
import 'package:knittda/src/data/repositories/report_repository.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:knittda/src/domain/repository/feed_api_repository.dart';
import 'package:knittda/src/domain/repository/project_api_repository.dart';
import 'package:knittda/src/domain/use_case/create_record_use_case.dart';
import 'package:knittda/src/domain/use_case/create_work_use_case.dart';
import 'package:knittda/src/domain/use_case/delete_record_use_case.dart';
import 'package:knittda/src/domain/use_case/delete_work_use_case.dart';
//import 'package:knittda/src/domain/use_case/feed_service.dart';
import 'package:knittda/src/domain/use_case/get_feed_use_case.dart';
import 'package:knittda/src/domain/use_case/get_project_previews_use_case.dart';
import 'package:knittda/src/domain/use_case/get_question_use_case.dart';
import 'package:knittda/src/domain/use_case/get_record_use_case.dart';
import 'package:knittda/src/domain/use_case/get_records_use_case.dart';
import 'package:knittda/src/domain/use_case/get_report_use_case.dart';
import 'package:knittda/src/domain/use_case/get_work_previews_use_case.dart';
import 'package:knittda/src/domain/use_case/get_work_use_case.dart';
import 'package:knittda/src/domain/use_case/get_works_use_case.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';
import 'package:knittda/src/domain/use_case/update_record_use_case.dart';
import 'package:knittda/src/domain/use_case/update_work_use_case.dart';
import 'package:knittda/src/domain/use_case/work_use_cases.dart';
import 'package:knittda/src/presentation/feed/feed_view_model.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_view_model.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';

import 'package:knittda/src/presentation/view_models/report_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_list_view_model.dart';
//import 'package:knittda/src/presentation/view_models/work_preview_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/data_sources/auth_interceptor.dart';

Future<List<SingleChildWidget>> getProviders() async {
  final tokenStorage = TokenStorage();

  return [
    Provider<TokenStorage>.value(value: tokenStorage),

    Provider<Dio>(
      create: (_) {
        final dio = Dio(BaseOptions(baseUrl: Env.apiBaseUrl));
        dio.interceptors.add(AuthInterceptor(tokenStorage));
        return dio;
      },
    ),

    ProxyProvider<Dio, AuthRepository>(
      update: (_, dio, __) => AuthRepository(dio),
    ),
    ChangeNotifierProvider<AuthViewModel>(
      create: (context) => AuthViewModel(
        KaKaoLogin(),
        context.read<AuthRepository>(),
        tokenStorage,
        Platform.isIOS ? SocialLoginApple() : null,
      ),
    ),

    ProxyProvider<Dio, WorkRepository>(
      update: (_, dio, __) => WorkRepository(dio),
    ),
    ProxyProvider<WorkRepository, WorkUseCases>(
      update: (_, repo, __) => WorkUseCases(
        createWork:  CreateWorkUseCase(repo),
        deleteWork:  DeleteWorkUseCase(repo),
        getWork:     GetWorkUseCase(repo),
        getWorks:    GetWorksUseCase(repo),
        updateWork:  UpdateWorkUseCase(repo),
        getWorkPreviews: GetWorkPreviewsUseCase(repo),
      ),
    ),
    ChangeNotifierProvider<WorkListViewModel>(
      create: (context) => WorkListViewModel(context.read<WorkUseCases>()),
    ),
    // ChangeNotifierProvider<WorkPreviewViewModel>(
    //   create: (context) =>
    //       WorkPreviewViewModel(context.read<WorkUseCases>()),
    // ),

    ProxyProvider<Dio, RecordRepository>(
      update: (_, dio, __) => RecordRepository(dio),
    ),
    ProxyProvider<RecordRepository, RecordUseCases>(
      update: (_, repo, __) => RecordUseCases(
        createRecord: CreateRecordUseCase(repo),
        deleteRecord: DeleteRecordUseCase(repo),
        getRecord:    GetRecordUseCase(repo),
        getRecords:   GetRecordsUseCase(repo),
        updateRecord: UpdateRecordUseCase(repo),
        getQuestion: GetQuestionUseCase(repo),
      ),
    ),

    ProxyProvider<Dio, ReportRepository>(
      update: (_, dio, __) => ReportRepository(dio),
    ),
    ProxyProvider<ReportRepository, GetReportUseCase>(
      update: (_, repo, __) => GetReportUseCase(repo),
    ),
    ChangeNotifierProxyProvider<AuthViewModel, ReportViewModel>(
      create: (context) => ReportViewModel(context.read<GetReportUseCase>()),
      update: (context, auth, vm) {
        vm ??= ReportViewModel(context.read<GetReportUseCase>());

        // 탈퇴/로그아웃 등으로 인증 해제되면 화면 메모리 캐시도 즉시 정리
        if (auth.status == AuthStatus.unauthenticated) {
          vm.reset();
        }
        return vm;
      },
    ),

    // ProxyProvider<Dio, FeedRepository>(
    //   update: (_, dio, __) => FeedRepository(dio),
    // ),
    // ProxyProvider<FeedRepository, FeedService>(
    //   update: (_, repo, __) => FeedService(repo),
    // ),
    // ChangeNotifierProvider<FeedViewModel>(
    //   create: (context) => FeedViewModel(context.read<FeedService>()),
    // ),

    ProxyProvider<Dio, ProjectApi>(
      update: (context, dio, _) => ProjectApi(dio),
    ),
    ProxyProvider<ProjectApi, ProjectApiRepository>(
      update: (context, api, _) => ProjectApiRepositoryImpl(api),
    ),
    ProxyProvider<ProjectApiRepository, GetProjectPreviewsUseCase>(
      update: (context, repository, _) => GetProjectPreviewsUseCase(repository),
    ),
    ChangeNotifierProvider<ProjectPreviewsViewModel>(
      create: (context) => ProjectPreviewsViewModel(context.read<GetProjectPreviewsUseCase>()),
    ),

    ProxyProvider<Dio, FeedApi>(
      update: (context, dio, _) => FeedApi(dio),
    ),
    ProxyProvider<FeedApi, FeedApiRepository>(
      update: (context, api, _) => FeedApiRepositoryImpl(api),
    ),
    ProxyProvider<FeedApiRepository, GetFeedUseCase>(
      update: (context, repository, _) => GetFeedUseCase(repository),
    ),
    ChangeNotifierProvider<FeedViewModel>(
      create: (context) => FeedViewModel(context.read<GetFeedUseCase>()),
    ),
  ];
}