import 'package:flutter/material.dart';

import 'package:knittda/src/presentation/screens/login.dart';
import 'package:knittda/src/presentation/widgets/listitems/more_menu_list.dart';

import 'package:provider/provider.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';


class MoreMenu extends StatelessWidget {
  const MoreMenu({super.key});

  void onLogout (BuildContext context) async{
    final loginViewModel = context.read<AuthViewModel>();
    await loginViewModel.logout();

    //네비게이션 스택 완전 초기화
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const Login()),
          (route) => false,
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
