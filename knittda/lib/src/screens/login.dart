import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/viewmodels/login_view_model.dart';
import 'home.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.watch<LoginViewModel>();

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
                final success = await loginViewModel.login();
                if (success) {
                  print("로그인 성공");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => Home()),
                  );
                } else {
                  print("로그인 실패");
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