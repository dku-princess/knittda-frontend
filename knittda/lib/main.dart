import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/auth_interceptor.dart';
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
import 'package:knittda/src/presentation/view_models/feed_view_model.dart';
import 'package:knittda/src/presentation/view_models/record_view_model.dart';
import 'package:knittda/src/presentation/view_models/report_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_view_model.dart';
import './src/app.dart';

import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

import 'package:provider/provider.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';
import 'package:knittda/src/data/data_sources/kakao_login.dart';
import 'package:knittda/src/data/repositories/auth_repository.dart';
import 'package:knittda/src/core/storage/token_storage.dart';

import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'env.dart';
import 'package:dio/dio.dart';

import 'src/domain/use_case/work_use_cases.dart';

// 앱 실행
Future<void> main() async {
  await runZonedGuarded(() async {
    // 바인딩 초기화는 반드시 runZoned 내부에서
    WidgetsFlutterBinding.ensureInitialized();

    if (!kDebugMode) {
      FlutterError.onError = (FlutterErrorDetails details) async {
        FlutterError.presentError(details);
        await Sentry.captureException(
          details.exception,
          stackTrace: details.stack,
        );
      };


      // Sentry 초기화
      await SentryFlutter.init((options) {
        options.dsn = SentryFlutterDns;
        options.attachStacktrace = true;
      });
    }

    // Kakao SDK 초기화 (필수 키 입력!)
    KakaoSdk.init(nativeAppKey: kakaoNativeAppKey);

    // 앱 실행
    runApp(
      MultiProvider(
        providers: [
          /// TokenStorage — 싱글톤
          Provider<TokenStorage>(
            create: (_) => TokenStorage(),
          ),

          /// Dio — TokenStorage 주입
          Provider<Dio>(
            create: (context) {
              final tokenStorage = context.read<TokenStorage>();
              final dio = Dio(
                BaseOptions(baseUrl: baseUrl),
              );
              dio.interceptors.add(AuthInterceptor(tokenStorage));
              return dio;
            },
          ),

          /// AuthRepository — Dio 주입
          Provider<AuthRepository>(
            create: (context) {
              final dio = context.read<Dio>();
              return AuthRepository(dio);
            },
          ),

          /// AuthViewModel — SocialLogin, AuthRepository, TokenStorage 주입
          ChangeNotifierProvider<AuthViewModel>(
            create: (context) => AuthViewModel(
              KaKaoLogin(),
              context.read<AuthRepository>(),
              context.read<TokenStorage>(),
            ),
          ),

          // work
          Provider<WorkRepository>(
            create: (context) {
              final dio = context.read<Dio>();
              return WorkRepository(dio);
            },
          ),

          /// WorkUseCases
          Provider<WorkUseCases>(
            create: (context) {
              final repository = context.read<WorkRepository>();
              return WorkUseCases(
                createWork: CreateWorkUseCase(repository),
                deleteWork: DeleteWorkUseCase(repository),
                getWork: GetWorkUseCase(repository),
                getWorks: GetWorksUseCase(repository),
                updateWork: UpdateWorkUseCase(repository),
              );
            },
          ),

          /// WorkViewModel
          ChangeNotifierProvider<WorkViewModel>(
            create: (context) {
              final useCases = context.read<WorkUseCases>();
              return WorkViewModel(
                useCases,
              );
            },
          ),

          // record
          ChangeNotifierProvider<RecordRepository>(
            create: (context) {
              final dio = context.read<Dio>();
              return RecordRepository(dio);
            },
          ),

          Provider<RecordUseCases>(
            create: (context) {
              final repository = context.read<RecordRepository>();
              return RecordUseCases(
                createRecord: CreateRecordUseCase(repository),
                deleteRecord: DeleteRecordUseCase(repository),
                getRecord: GetRecordUseCase(repository),
                getRecords: GetRecordsUseCase(repository),
                updateRecord: UpdateRecordUseCase(repository),
              );
            },
          ),

          ChangeNotifierProvider<RecordViewModel>(
            create: (context) {
              final useCases = context.read<RecordUseCases>();
              final repository = context.read<RecordRepository>();
              return RecordViewModel(
                useCases: useCases,
                repository: repository,
              );
            },
          ),

          Provider<ReportRepository>(
            create: (_) => ReportRepository(),
          ),
          ProxyProvider<ReportRepository, GetReportUseCase>(
            update: (_, repo, __) => GetReportUseCase(reportRepository: repo),
          ),
          ChangeNotifierProxyProvider2<AuthViewModel, GetReportUseCase, ReportViewModel>(
            create: (ctx) => ReportViewModel(
              authViewModel: ctx.read<AuthViewModel>(),
              getReportUseCase: ctx.read<GetReportUseCase>(),
            ),
            update: (ctx, auth, getReportUseCase, prev) {
              return ReportViewModel(
                authViewModel: auth,
                getReportUseCase: getReportUseCase,
              );
            },
          ),

          Provider<FeedRepository>(
            create: (context) {
              final dio = context.read<Dio>();
              return FeedRepository(dio);
            },
          ),
          // ③ Service (Repository 의존)
          ProxyProvider<FeedRepository, FeedService>(
            update: (_, repo, __) => FeedService(repo),
          ),

          // ④ ViewModel (Service 의존) ─ 필요 시 화면별 분리도 가능
          ChangeNotifierProvider<FeedViewModel>(
            create: (context) => FeedViewModel(
              context.read<FeedService>(),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stackTrace) async {
    // 비동기 예외 추적
    if (!kDebugMode) {
      await Sentry.captureException(error, stackTrace: stackTrace);
    }
  });
}