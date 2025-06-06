import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/screens/home.dart';
import 'package:knittda/src/presentation/screens/main_page/login.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';
//import 'package:knittda/src/presentation/screens/work_detail/report_ui.dart';

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

        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFF2F2F7),
        ),
      ),

      home: Consumer<AuthViewModel>(
        builder: (_, auth, __) {
          switch (auth.status) {
            case AuthStatus.loading:
              return const SplashScreen();
            case AuthStatus.authenticated:
              return Home();
            case AuthStatus.unauthenticated:
              return const Login();
          }
        },
      ),

      //home: ReportUi(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

