import 'package:flutter/material.dart';
import './src/app.dart';

import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

import 'package:provider/provider.dart';
import 'package:knittda/src/viewmodels/login_view_model.dart';
import 'package:knittda/src/services/kakao_login.dart';
import 'package:knittda/src/repositories/auth_repository.dart';

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
          create: (_) => LoginViewModel(KaKaoLogin(),AuthRepository()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}