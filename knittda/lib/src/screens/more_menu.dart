import 'package:flutter/material.dart';
import 'package:knittda/src/component/more_menu_list.dart';

class MoreMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            "더보기",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          MoreMenuList(title: '로그아웃'),
          MoreMenuList(title: '문의하기'),
          MoreMenuList(title: '회원탈퇴'),
        ],
      ),
    );
  }
}