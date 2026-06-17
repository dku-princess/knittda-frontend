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
import 'package:flutter/foundation.dart';
import 'app_config.dart';

// 앱 실행
Future<void> main() async {
  await runZonedGuarded(
    () async {
      // 바인딩 초기화는 반드시 runZoned 내부에서
      WidgetsFlutterBinding.ensureInitialized();

      //세로 방향 고정
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      // Firebase 초기화 (AnalyticsService가 사용하기 전에 실행)
      // 실패해도 앱은 계속 진행 — GA만 누락되고 검은 화면은 방지
      try {
        await Firebase.initializeApp();
      } catch (e, st) {
        await Sentry.captureException(e, stackTrace: st);
      }

      if (!kDebugMode) {
        await SentryFlutter.init((options) {
          options.dsn = AppConfig.sentryDsn;
          options.environment = AppConfig.sentryEnvironment;
          options.attachStacktrace = true;
          options.sendDefaultPii = false;
          options.tracesSampleRate = 1.0;
          if (AppConfig.sentryRelease.isNotEmpty) {
            options.release = AppConfig.sentryRelease;
          }
          options.tracePropagationTargets.add(AppConfig.apiBaseUrl);
        });
      }

      //provider 모음 생성
      final providers = await getProviders();

      // Kakao SDK 초기화 (필수 키 입력!)
      KakaoSdk.init(nativeAppKey: AppConfig.kakaoNativeAppKey);

      // 앱 실행
      runApp(MultiProvider(providers: providers, child: const MyApp()));
    },
    (error, stackTrace) async {
      await Sentry.captureException(error, stackTrace: stackTrace);
    },
  );
}
