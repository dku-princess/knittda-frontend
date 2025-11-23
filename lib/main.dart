import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:knittda/src/di/provider_setup.dart';
import './src/app.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'env.dart';

// 앱 실행
Future<void> main() async {
  await runZonedGuarded(() async {
    // 바인딩 초기화는 반드시 runZoned 내부에서
    WidgetsFlutterBinding.ensureInitialized();

    //세로 방향 고정
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    //provider 모음 생성
    final providers = await getProviders();

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
        options.dsn = Env.SentryFlutterDns;
        options.attachStacktrace = true;
        options.sendDefaultPii = false;
      });
    }

    // Firebase 초기화
    if (Platform.isIOS){
      await Firebase.initializeApp();
    }

    // Kakao SDK 초기화 (필수 키 입력!)
    KakaoSdk.init(nativeAppKey: Env.kakaoNativeAppKey);

    // 앱 실행
    runApp(
      MultiProvider(
        providers: providers,
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