import 'package:flutter/material.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:knittda/src/data/repositories/work_repositories.dart';
import 'package:knittda/src/domain/use_case/create_record_use_case.dart';
import 'package:knittda/src/domain/use_case/create_work_use_case.dart';
import 'package:knittda/src/domain/use_case/delete_record_use_case.dart';
import 'package:knittda/src/domain/use_case/delete_work_use_case.dart';
import 'package:knittda/src/domain/use_case/get_record_use_case.dart';
import 'package:knittda/src/domain/use_case/get_records_use_case.dart';
import 'package:knittda/src/domain/use_case/get_work_use_case.dart';
import 'package:knittda/src/domain/use_case/get_works_use_case.dart';
import 'package:knittda/src/domain/use_case/update_record_use_case.dart';
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

        ChangeNotifierProxyProvider<AuthViewModel, UserViewModel>(
          create: (ctx) => UserViewModel(ctx.read<AuthViewModel>()),
          update: (ctx, auth, prev) {
            prev?.update(auth);
            return prev ?? UserViewModel(auth);
          },
        ),

        Provider<WorkRepositories>(
          create: (_) => WorkRepositories(),
        ),

        ProxyProvider<WorkRepositories, CreateWorkUseCase>(
          update: (_, repo, __) => CreateWorkUseCase(workRepositories: repo),
        ),

        ProxyProvider<WorkRepositories, DeleteWorkUseCase>(
          update: (_, repo, __) => DeleteWorkUseCase(workRepositories: repo),
        ),

        ProxyProvider<WorkRepositories, GetWorkUseCase>(
          update: (_, repo, __) => GetWorkUseCase(workRepositories: repo),
        ),

        ProxyProvider<WorkRepositories, GetWorksUseCase>(
          update: (_, repo, __) => GetWorksUseCase(workRepositories: repo),
        ),

        ChangeNotifierProxyProvider5<
          AuthViewModel,
          CreateWorkUseCase,
          DeleteWorkUseCase,
          GetWorkUseCase,
          GetWorksUseCase,
          WorkViewModel
        > (create: (ctx) => WorkViewModel(
            authViewModel: ctx.read<AuthViewModel>(),
            createWorkUseCase: ctx.read<CreateWorkUseCase>(),
            deleteWorkUseCase: ctx.read<DeleteWorkUseCase>(),
            getWorkUseCase: ctx.read<GetWorkUseCase>(),
            getWorksUseCase: ctx.read<GetWorksUseCase>(),
          ),
          update: (ctx, auth, createUseCase, deleteUseCase, getWorkUseCase, getWorksUseCase, prev) {
            if (prev != null) {
              prev.update(auth);
              return prev;
            }
            return WorkViewModel(
              authViewModel:auth,
              createWorkUseCase: createUseCase,
              deleteWorkUseCase: deleteUseCase,
              getWorkUseCase: getWorkUseCase,
              getWorksUseCase: getWorksUseCase
            );
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

        ProxyProvider<RecordsRepository, GetRecordUseCase>(
          update: (_, repo, __) => GetRecordUseCase(recordsRepository: repo),
        ),

        ProxyProvider<RecordsRepository, GetRecordsUseCase>(
          update: (_, repo, __) => GetRecordsUseCase(recordsRepository: repo),
        ),

        ProxyProvider<RecordsRepository, UpdateRecordUseCase>(
          update: (_, repo, __) => UpdateRecordUseCase(recordsRepository: repo),
        ),

        ChangeNotifierProxyProvider6<
          AuthViewModel,
          CreateRecordUseCase,
          DeleteRecordUseCase,
          GetRecordUseCase,
          GetRecordsUseCase,
          UpdateRecordUseCase,
          RecordViewModel
        > (create: (ctx) => RecordViewModel(
            authViewModel: ctx.read<AuthViewModel>(),
            createRecordUseCase: ctx.read<CreateRecordUseCase>(),
            deleteRecordUseCase: ctx.read<DeleteRecordUseCase>(),
            getRecordUseCase: ctx.read<GetRecordUseCase>(),
            getRecordsUseCase: ctx.read<GetRecordsUseCase>(),
            updateRecordUseCase: ctx.read<UpdateRecordUseCase>(),
          ),
          update: (ctx, auth, createUseCase, deleteUseCase, getRecordUseCase, getRecordsUseCase, updateUseCase,prev) {
            if (prev != null) {
              prev.update(auth);
              return prev;
            }
            return RecordViewModel(
              authViewModel: auth,
              createRecordUseCase: createUseCase,
              deleteRecordUseCase: deleteUseCase,
              getRecordUseCase: getRecordUseCase,
              getRecordsUseCase: getRecordsUseCase,
              updateRecordUseCase: updateUseCase,
            );
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}