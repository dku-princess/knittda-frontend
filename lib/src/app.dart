import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
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

      //모든 항목에서 pretendard 폰트 사용
      theme: ThemeData(
        fontFamily: 'Pretendard',
        splashColor: Colors.transparent, //클릭시 퍼지는 효과 제거
        //highlightColor: Colors.transparent, //클릭시 원형 효과 제거
        scaffoldBackgroundColor: Colors.white, //바탕화면을 하얗게 설정
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white, //상단바 배경을 하얗게 설정
          elevation: 0, //그림자 제거
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white, //하단 네비게이션 바 배경을 하얗게 설정
        ),

        //디자인 시스템 녹색을 시드로 사용해 onPrimary/surfaceTint 등 파생 색상까지 일관되게 생성
        colorScheme: ColorScheme.fromSeed(seedColor: PRIMARY_COLOR),
        //로딩 스피너 기본색을 녹색으로 (색 미지정 위젯이 남색으로 표시되던 문제 해결)
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: PRIMARY_COLOR,
        ),
        //탭 라벨/인디케이터 기본색을 녹색으로
        tabBarTheme: const TabBarThemeData(
          labelColor: PRIMARY_COLOR,
          unselectedLabelColor: Colors.grey,
          indicatorColor: PRIMARY_COLOR,
        ),
      ),

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
