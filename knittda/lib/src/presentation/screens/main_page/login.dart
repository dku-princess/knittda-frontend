import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';
import 'package:knittda/src/presentation/screens/home.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.read<AuthViewModel>();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "로고",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 150),
            child: GestureDetector(
              onTap: () async {
                final success = await loginViewModel.loginWithKakao();
                if (success) {
                  //네비게이션 스택 완전 초기화
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const Home()),
                        (route) => false,
                  );
                }
              },
              child: Image.asset(
                "assets/image/kakao_login_medium_wide.png",
              ),
            ),
          ),
        ],
      ),
    );
  }
}