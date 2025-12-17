import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:knittda/src/domain/util/social_login_type.dart';
import 'package:knittda/src/presentation/login/login_event.dart';
import 'package:knittda/src/presentation/login/login_view_model.dart';
import 'package:knittda/src/presentation/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/presentation/login/login_ui_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StreamSubscription? _subscription;
  int _tapCount = 0;
  DateTime? _lastTapTime;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        final viewModel = context.read<LoginViewModel>();

        _subscription = viewModel.eventStream.listen((event) {
          if (mounted) {
            switch (event) {
              case Login():
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              case ShowSnackBar(:final message):
                final snackBar = SnackBar(content: Text(message));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        });
      }
    });
  }

  void _handleTap() {
    final now = DateTime.now();
    
    // 2초 이내에 연속으로 탭한 경우만 카운트
    if (_lastTapTime != null && 
        now.difference(_lastTapTime!) < const Duration(seconds: 2)) {
      _tapCount++;
    } else {
      _tapCount = 1;
    }
    
    _lastTapTime = now;

    // 20번 탭하면 Admin 버튼 표시/숨김 토글
    if (_tapCount >= 20) {
      final viewModel = context.read<LoginViewModel>();
      viewModel.toggleAdminButton();
      _tapCount = 0; // 리셋
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
    final state = viewModel.state;

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: _handleTap,
            behavior: HitTestBehavior.translucent,
            child: Column(
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
                  padding: const EdgeInsets.only(bottom: 120),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await viewModel.onEvent(
                            LoginEvent.socialLogin(type: SocialLoginType.kakao()),
                          );
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
                            await viewModel.onEvent(
                              LoginEvent.socialLogin(
                                type: SocialLoginType.apple(),
                              ),
                            );
                          },
                          child: Image.asset(
                            "assets/image/apple_login.png",
                            width: 300,
                          ),
                        ),
                      ],

                      if (state.showAdminButton) ...[
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () async {
                            await viewModel.onEvent(
                              LoginEvent.adminLogin(),
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey[600],
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                          ),
                          child: const Text(
                            'Admin Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (state.isLoading)
            Positioned.fill(
              child: AbsorbPointer(
                child: Container(
                  color: Colors.black26,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
