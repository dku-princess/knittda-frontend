import 'package:flutter/material.dart';
import 'package:knittda/src/widgets/listitems/more_menu_list.dart';

import 'package:provider/provider.dart';
import 'package:knittda/src/viewmodels/auth_view_model.dart';
import 'login.dart';

class MoreMenu extends StatelessWidget {

  void onLogout (BuildContext context) async{
    final loginViewModel = context.read<AuthViewModel>();
    await loginViewModel.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => Login()),
    );
  }

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

      //ListTile
      body: Column(
        children: [
          SizedBox(height: 20),
          MoreMenuList(title: '로그아웃', onTab: () => onLogout(context)),
          MoreMenuList(title: '문의하기', onTab: () =>()),
          MoreMenuList(title: '회원탈퇴', onTab: () =>()),
        ],
      ),
    );
  }
}
