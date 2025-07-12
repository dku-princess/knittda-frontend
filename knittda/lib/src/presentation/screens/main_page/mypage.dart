import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/screens/main_page/login.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';
import 'package:knittda/src/presentation/widgets/listitems/more_menu_list.dart';
import 'package:provider/provider.dart';
import '../../view_models/user_view_model.dart';

class Mypage extends StatelessWidget {
  const Mypage({super.key});

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
    final userViewModel = context.watch<UserViewModel>();

    if (!userViewModel.isReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //가로방향: 좌측정렬
        children: [
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 24),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300), //bottom 외각선
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: userViewModel.profileImage,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(width: 12),
                Text(
                  userViewModel.nickname,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // 로그아웃 버튼
          SizedBox(height: 20),
          MoreMenuList(title: '로그아웃', onTab: () => onLogout(context)),
        ],
      ),
    );
  }
}