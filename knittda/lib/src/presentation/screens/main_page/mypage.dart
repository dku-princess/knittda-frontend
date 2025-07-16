import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/screens/main_page/login.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';

class Mypage extends StatelessWidget {
  const Mypage({super.key});

  void onLogout(BuildContext context) async {
    final auth = context.read<AuthViewModel>();
    await auth.logout();

    // 네비게이션 스택 초기화
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const Login()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();

    if (auth.status == AuthStatus.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (auth.status == AuthStatus.unauthenticated || auth.user == null) {
      return const Scaffold(
        body: Center(child: Text('로그인이 필요합니다.')),
      );
    }

    final user = auth.user!;

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  backgroundImage: user.profileImageUrl != null
                      ? NetworkImage(user.profileImageUrl!)
                      : null,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(width: 12),
                Text(
                  user.nickname ?? '이름 없음',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // 로그아웃 버튼
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: const Text('로그아웃'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onLogout(context),
          ),
        ],
      ),
    );
  }
}