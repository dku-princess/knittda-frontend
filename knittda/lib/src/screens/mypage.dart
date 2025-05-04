import 'package:flutter/material.dart';
import 'package:knittda/src/widgets/listitems/user_mypage.dart';

class Mypage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            '마이 페이지',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: UserMypage(name: "홍길동", email: "loveyou@dankook.ac.kr"),
    );
  }
}