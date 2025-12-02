import 'package:flutter/material.dart';
import 'package:knittda/src/domain/use_case/admin_login_use_case.dart';
import 'package:knittda/src/domain/use_case/auto_login_use_case.dart';
import 'package:knittda/src/domain/use_case/social_login_use_case.dart';
import 'package:knittda/src/presentation/login/login_screen.dart';
import 'package:knittda/src/presentation/login/login_view_model.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF2F2F7)),
      ),

      home: ChangeNotifierProvider(
        create: (_) => LoginViewModel(
          context.read<AutoLoginUseCase>(),
          context.read<SocialLoginUseCase>(),
          context.read<AdminLoginUseCase>(),
        ),
        child: const LoginScreen(),
      ),
    );
  }
}
