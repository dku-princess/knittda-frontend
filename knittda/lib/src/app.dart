import 'package:flutter/material.dart';
import 'package:knittda/src/viewmodels/auth_view_model.dart';
import 'package:provider/provider.dart';

import 'screens/login.dart';
import 'screens/home.dart';

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
      ),

      home: Consumer<AuthViewModel>(
        builder: (_, auth, __) {
          // 아직 초기화(토큰 체크)가 끝나지 않았다면 Splash
          if (!auth.initialized) {
            return const SplashScreen();
          }

          // 초기화 끝 → 토큰이 있으면 Home, 없으면 Login
          return auth.jwt == null ? Login() : const Home();
        },
      ),
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

