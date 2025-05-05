import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/work_details.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //앱 처음 실행할 때 접속할 페이지
      initialRoute: '/',
      routes: {
        '/': (context) => WorkDetails(),
      },

      //모든 항목에서 pretendard 폰트 사용
      theme: ThemeData(
        fontFamily: 'Pretendard',
        splashColor: Colors.transparent, //클릭시 퍼지는 효과 제거
        //highlightColor: Colors.transparent, //클릭시 원형 효과 제거
      ),

    );
  }
}

