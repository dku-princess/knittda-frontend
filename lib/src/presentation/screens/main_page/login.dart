import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';
import 'package:knittda/src/presentation/screens/home.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = context.read<AuthViewModel>();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/image/logo.png',
                width: 150,
                height: 150,
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                // 일반 카카오 로그인
                GestureDetector(
                  onTap: () async {
                    final success = await authVM.loginWithKakao();

                    if (!context.mounted) return;
                    if (success) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const Home()),
                            (_) => false,
                      );
                    }
                  },
                  child: Image.asset(
                    "assets/image/kakao_login_large_wide.png",
                    width: 300,
                  ),
                ),
                const SizedBox(height: 20),
                // 웹 로그인 버튼 (iPhone mini 등에서 사용)
                GestureDetector(
                  onTap: () async {
                    final success = await authVM.loginWithKakaoWeb();

                    if (!context.mounted) return;
                    if (success) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const Home()),
                            (_) => false,
                      );
                    }
                  },
                  child: const Text(
                    '웹으로 카카오 로그인',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}