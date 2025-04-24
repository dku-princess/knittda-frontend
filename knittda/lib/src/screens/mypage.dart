import 'package:flutter/material.dart';
import 'package:knittda/src/component/user_mypage.dart';

class Mypage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8.0), // 원하는 만큼 조절 가능
          child: Text(
            "마이 페이지",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: UserListItem(name: "홍길동", email: "loveyou@dankook.ac.kr"),
    );
  }
}