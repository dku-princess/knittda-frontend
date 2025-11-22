import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';

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
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await authVM.loginWithKakao();
                  },
                  child: Image.asset(
                    "assets/image/kakao_login_large_wide.png",
                    width: 300,
                  ),
                ),

                if (Platform.isIOS) ...[
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      await authVM.loginWithApple();
                    },
                    child: Image.asset(
                      "assets/image/apple_login.png",
                      width: 300,
                    ),
                  ),
                ],

                const SizedBox(height: 10),

                TextButton(
                  onPressed: () async{
                   await authVM.admin();
                  },
                  child: Text(
                    'Admin Login',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}