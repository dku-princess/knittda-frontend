import 'package:dio/dio.dart';
import 'package:knittda/env.dart';
import 'package:knittda/src/core/storage/token_storage.dart';
import 'package:knittda/src/data/data_sources/kakao_login.dart';
import 'package:knittda/src/data/repositories/auth_repository.dart';
import 'package:knittda/src/data/repositories/feed_repository.dart';
import 'package:knittda/src/data/repositories/record_repository.dart';
import 'package:knittda/src/data/repositories/report_repository.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:knittda/src/domain/use_case/create_record_use_case.dart';
import 'package:knittda/src/domain/use_case/create_work_use_case.dart';
import 'package:knittda/src/domain/use_case/delete_record_use_case.dart';
import 'package:knittda/src/domain/use_case/delete_work_use_case.dart';
import 'package:knittda/src/domain/use_case/feed_service.dart';
import 'package:knittda/src/domain/use_case/get_record_use_case.dart';
import 'package:knittda/src/domain/use_case/get_records_use_case.dart';
import 'package:knittda/src/domain/use_case/get_report_use_case.dart';
import 'package:knittda/src/domain/use_case/get_work_use_case.dart';
import 'package:knittda/src/domain/use_case/get_works_use_case.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';
import 'package:knittda/src/domain/use_case/update_record_use_case.dart';
import 'package:knittda/src/domain/use_case/update_work_use_case.dart';
import 'package:knittda/src/domain/use_case/work_use_cases.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';
import 'package:knittda/src/presentation/view_models/feed_view_model.dart';
import 'package:knittda/src/presentation/view_models/report_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/data_sources/auth_interceptor.dart';

Future<List<SingleChildWidget>> getProviders() async {
  final tokenStorage = TokenStorage();

  return [
    Provider<TokenStorage>.value(value: tokenStorage),

    Provider<Dio>(
      create: (_) {
        final dio = Dio(BaseOptions(baseUrl: baseUrl));
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
      ),
    ),
    ChangeNotifierProvider<WorkListViewModel>(
      create: (context) => WorkListViewModel(context.read<WorkUseCases>()),
    ),

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
      ),
    ),

    ProxyProvider<Dio, ReportRepository>(
      update: (_, dio, __) => ReportRepository(dio),
    ),
    ProxyProvider<ReportRepository, GetReportUseCase>(
      update: (_, repo, __) => GetReportUseCase(repo),
    ),
    ChangeNotifierProvider<ReportViewModel>(
      create: (context) => ReportViewModel(context.read<GetReportUseCase>()),
    ),

    ProxyProvider<Dio, FeedRepository>(
      update: (_, dio, __) => FeedRepository(dio),
    ),
    ProxyProvider<FeedRepository, FeedService>(
      update: (_, repo, __) => FeedService(repo),
    ),
    ChangeNotifierProvider<FeedViewModel>(
      create: (context) => FeedViewModel(context.read<FeedService>()),
    ),
  ];
}