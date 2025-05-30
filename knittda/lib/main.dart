import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:knittda/src/domain/use_case/delete_record_use_case.dart';
import 'package:knittda/src/domain/use_case/delete_work_use_case.dart';
import 'package:knittda/src/domain/use_case/get_record_use_case.dart';
import 'package:knittda/src/domain/use_case/get_records_use_case.dart';
import 'package:knittda/src/domain/use_case/get_work_use_case.dart';
import 'package:knittda/src/domain/use_case/get_works_use_case.dart';
import 'package:knittda/src/presentation/view_models/record_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_view_model.dart';
import './src/app.dart';

import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

import 'package:provider/provider.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';
import 'package:knittda/src/data/datasources/kakao_login.dart';
import 'package:knittda/src/data/repositories/auth_repository.dart';
import 'package:knittda/src/core/storage/token_storage.dart';
import 'package:knittda/src/presentation/view_models/user_view_model.dart';

import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'env.dart';

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
          ChangeNotifierProvider<AuthViewModel>(
            //lazy: false,
            create: (_) => AuthViewModel(
              KaKaoLogin(),
              AuthRepository(),
              TokenStorage(),
            ),
          ),
          ChangeNotifierProxyProvider<AuthViewModel, UserViewModel>(
            create: (ctx) => UserViewModel(ctx.read<AuthViewModel>()),
            update: (ctx, auth, prev) {
              prev?.update(auth);
              return prev ?? UserViewModel(auth);
            },
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