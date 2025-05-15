import 'package:flutter/material.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:knittda/src/data/repositories/work_repositories.dart';
import 'package:knittda/src/domain/use_case/create_record_use_case.dart';
import 'package:knittda/src/domain/use_case/delete_record_use_case.dart';
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

// 앱 실행
void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '80b636a62e74a4a39f74f6f3fef235fd',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(
          lazy: false,
          create: (_) => AuthViewModel(
            KaKaoLogin(),
            AuthRepository(),
            TokenStorage(),
          ),
        ),

        Provider<WorkRepositories>(
          create: (_) => WorkRepositories(),
        ),

        ChangeNotifierProxyProvider<AuthViewModel, UserViewModel>(
          create: (ctx) => UserViewModel(ctx.read<AuthViewModel>()),
          update: (ctx, auth, prev) {
            prev?.update(auth);
            return prev ?? UserViewModel(auth);
          },
        ),

        ChangeNotifierProxyProvider2<AuthViewModel, WorkRepositories, WorkViewModel>(
          create: (ctx) => WorkViewModel(
            ctx.read<AuthViewModel>(),
            ctx.read<WorkRepositories>(),
          ),
          update: (ctx, auth, repo, prev) {
            prev?.update(auth);              // Auth 변경 반영
            return prev ?? WorkViewModel(auth, repo);
          },
        ),

        Provider<RecordsRepository>(
          create: (_) => RecordsRepository(),
        ),

        ProxyProvider<RecordsRepository, CreateRecordUseCase>(
          update: (_, repo, __) => CreateRecordUseCase(recordsRepository: repo),
        ),

        ProxyProvider<RecordsRepository, DeleteRecordUseCase>(
          update: (_, repo, __) => DeleteRecordUseCase(recordsRepository: repo),
        ),

        ChangeNotifierProxyProvider3<AuthViewModel, CreateRecordUseCase, DeleteRecordUseCase, RecordViewModel>(
          create: (ctx) => RecordViewModel(
            authViewModel: ctx.read<AuthViewModel>(),
            createRecordUseCase: ctx.read<CreateRecordUseCase>(),
            deleteRecordUseCase: ctx.read<DeleteRecordUseCase>(),
          ),
          update: (ctx, auth, createUseCase, deleteUseCase, prev) {
            if (prev != null) {
              prev.update(auth);
              return prev;
            }
            return RecordViewModel(
              authViewModel: auth,
              createRecordUseCase: createUseCase,
              deleteRecordUseCase: deleteUseCase
            );
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}