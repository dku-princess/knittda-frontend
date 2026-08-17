import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';
import 'package:knittda/src/data/data_sources/analytics_service.dart';
import 'package:knittda/src/domain/use_case/auto_login_use_case.dart';
import 'package:knittda/src/domain/use_case/get_user_use_case.dart';
import 'package:knittda/src/domain/use_case/social_login_use_case.dart';
import 'package:knittda/src/presentation/login/login_screen.dart';
import 'package:knittda/src/presentation/login/login_view_model.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        AnalyticsService.instance.observer,
        AnalyticsService.routeObserver,
      ],
      debugShowCheckedModeBanner: false,

      // 모든 항목에서 Pretendard 폰트 사용 · 디자인 토큰 기반 테마
      theme: AppTheme.light,

      home: ChangeNotifierProvider(
        create: (context) => LoginViewModel(
          context.read<AutoLoginUseCase>(),
          context.read<SocialLoginUseCase>(),
          context.read<GetUserUseCase>(),
        ),
        child: const LoginScreen(),
      ),
    );
  }
}
