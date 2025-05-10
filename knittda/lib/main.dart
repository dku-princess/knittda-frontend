import 'package:flutter/material.dart';
import 'package:knittda/src/data/repositories/work_repositories.dart';
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
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(KaKaoLogin(),AuthRepository(),TokenStorage()),
        ),
        ChangeNotifierProxyProvider<AuthViewModel, UserViewModel>(
          create: (context) => UserViewModel(context.read<AuthViewModel>()),
          update: (context, authViewModel, previous) =>
          previous!..update(authViewModel),
        ),
        ChangeNotifierProxyProvider<AuthViewModel, WorkViewModel>(
          create: (context) => WorkViewModel(context.read<AuthViewModel>(),WorkRepositories()),
          update: (context, authViewModel, previous) =>
          previous!..update(authViewModel),
        ),
      ],
      child: const MyApp(),
    ),
  );
}