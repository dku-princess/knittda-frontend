import 'package:flutter/material.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:knittda/src/data/repositories/work_repositories.dart';
import 'package:knittda/src/domain/use_case/create_record_use_case.dart';
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
        // 1) AuthViewModel ─ 앱 시작과 동시에 tryAutoLogin()
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

        // 3) UserViewModel ← AuthViewModel
        ChangeNotifierProxyProvider<AuthViewModel, UserViewModel>(
          create: (ctx) => UserViewModel(ctx.read<AuthViewModel>()),
          update: (ctx, auth, prev) {
            prev?.update(auth);
            return prev ?? UserViewModel(auth);
          },
        ),

        // 4) WorkViewModel ← AuthViewModel & WorkRepositories
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

        /// 2) CreateRecordUseCase ― RecordsRepository 의존
        ProxyProvider<RecordsRepository, CreateRecordUseCase>(
          update: (_, repo, __) => CreateRecordUseCase(recordsRepository: repo),
        ),

        /// 3) AddRecordViewModel ― AuthViewModel + CreateRecordUseCase 의존
        ChangeNotifierProxyProvider2<AuthViewModel, CreateRecordUseCase, RecordViewModel>(
          create: (ctx) => RecordViewModel(
            authViewModel: ctx.read<AuthViewModel>(),
            useCase:       ctx.read<CreateRecordUseCase>(),
          ),
          update: (ctx, auth, useCase, prev) {
            // Auth 또는 UseCase 가 새로 바뀌었을 때 ViewModel 에 반영
            if (prev != null) {
              prev.update(auth,useCase);
              // 필요 시 prev.updateUseCase(useCase);  ← 메서드 추가하는 방안 아래 참고
              return prev;
            }
            return RecordViewModel(authViewModel: auth, useCase: useCase);
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}