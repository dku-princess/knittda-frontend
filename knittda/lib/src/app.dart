import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/screens/home.dart';
import 'package:knittda/src/presentation/screens/login.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';
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
      ),

      home: Consumer<AuthViewModel>(
        builder: (_, auth, __) {
          switch (auth.status) {
            case AuthStatus.loading:
              return const SplashScreen();
            case AuthStatus.authenticated:
              return const Home();
            case AuthStatus.unauthenticated:
              return const Login();
          }
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

