import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/auth_interceptor.dart';
import 'package:knittda/src/data/repositories/feed_repository.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:knittda/src/data/repositories/report_repository.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:knittda/src/domain/use_case/delete_record_use_case.dart';
import 'package:knittda/src/domain/use_case/delete_work_use_case.dart';
import 'package:knittda/src/domain/use_case/feed_service.dart';
import 'package:knittda/src/domain/use_case/get_record_use_case.dart';
import 'package:knittda/src/domain/use_case/get_records_use_case.dart';
import 'package:knittda/src/domain/use_case/get_report_use_case.dart';
import 'package:knittda/src/domain/use_case/get_work_use_case.dart';
import 'package:knittda/src/domain/use_case/get_works_use_case.dart';
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

          ChangeNotifierProvider<WorkRepository>(create: (_) => WorkRepository()),
          ProxyProvider<WorkRepository, DeleteWorkUseCase>(
            update: (_, repo, __) => DeleteWorkUseCase(workRepository: repo),
          ),
          ProxyProvider<WorkRepository, GetWorkUseCase>(
            update: (_, repo, __) => GetWorkUseCase(workRepository: repo),
          ),
          ProxyProvider<WorkRepository, GetWorksUseCase>(
            update: (_, repo, __) => GetWorksUseCase(workRepository: repo),
          ),
          ChangeNotifierProxyProvider5<
              AuthViewModel,
              DeleteWorkUseCase,
              GetWorkUseCase,
              GetWorksUseCase,
              WorkRepository,
              WorkViewModel>(
            create: (ctx) => WorkViewModel(
              authViewModel: ctx.read<AuthViewModel>(),
              deleteWorkUseCase: ctx.read<DeleteWorkUseCase>(),
              getWorkUseCase: ctx.read<GetWorkUseCase>(),
              getWorksUseCase: ctx.read<GetWorksUseCase>(),
              workRepository: ctx.read<WorkRepository>(),
            ),
            update: (ctx, auth, deleteUseCase, getWorkUseCase, getWorksUseCase, workRepository,prev) {
              if (prev != null) {
                prev.update(auth);
                return prev;
              }

              return WorkViewModel(
                authViewModel: auth,
                deleteWorkUseCase: deleteUseCase,
                getWorkUseCase: getWorkUseCase,
                getWorksUseCase: getWorksUseCase,
                workRepository: workRepository
              );
            },
          ),
          ChangeNotifierProvider<RecordsRepository>(create: (_) => RecordsRepository()),
          ProxyProvider<RecordsRepository, DeleteRecordUseCase>(
            update: (_, repo, __) => DeleteRecordUseCase(recordsRepository: repo),
          ),
          ProxyProvider<RecordsRepository, GetRecordUseCase>(
            update: (_, repo, __) => GetRecordUseCase(recordsRepository: repo),
          ),
          ProxyProvider<RecordsRepository, GetRecordsUseCase>(
            update: (_, repo, __) => GetRecordsUseCase(recordsRepository: repo),
          ),
          ChangeNotifierProxyProvider5<
              AuthViewModel,
              DeleteRecordUseCase,
              GetRecordUseCase,
              GetRecordsUseCase,
              RecordsRepository,
              RecordViewModel>(
            create: (ctx) => RecordViewModel(
              authViewModel: ctx.read<AuthViewModel>(),
              deleteRecordUseCase: ctx.read<DeleteRecordUseCase>(),
              getRecordUseCase: ctx.read<GetRecordUseCase>(),
              getRecordsUseCase: ctx.read<GetRecordsUseCase>(),
              recordsRepository: ctx.read<RecordsRepository>(),
            ),
            update: (ctx, auth, deleteUseCase, getRecordUseCase, getRecordsUseCase, recordsRepository,prev) {
              if (prev != null) {
                prev.update(auth);
                return prev;
              }
              return RecordViewModel(
                authViewModel: auth,
                deleteRecordUseCase: deleteUseCase,
                getRecordUseCase: getRecordUseCase,
                getRecordsUseCase: getRecordsUseCase,
                recordsRepository: recordsRepository
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

          // ② Repository (Dio 의존)
          ProxyProvider<Dio, FeedRepository>(
            update: (_, dio, __) => FeedRepository(dio),
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