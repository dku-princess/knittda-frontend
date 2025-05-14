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
        /// 앱 시작 직후 바로 tryAutoLogin() 이 실행되도록 lazy: false
        ChangeNotifierProvider<AuthViewModel>(
          lazy: false,
          create: (_) => AuthViewModel(
            KaKaoLogin(),
            AuthRepository(),
            TokenStorage(),
          ),
        ),

        /// Auth 상태 변화만 받을 수 있도록 update() 최적화
        ChangeNotifierProxyProvider<AuthViewModel, UserViewModel>(
          create: (ctx) => UserViewModel(ctx.read<AuthViewModel>()),
          update: (ctx, auth, prev) {
            prev?.update(auth);
            return prev ?? UserViewModel(auth);
          },
        ),

        ChangeNotifierProxyProvider<AuthViewModel, WorkViewModel>(
          create: (ctx) => WorkViewModel(
            ctx.read<AuthViewModel>(),
            WorkRepositories(),
          ),
          update: (ctx, auth, prev) {
            prev?.update(auth);
            return prev ?? WorkViewModel(auth, WorkRepositories());
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}