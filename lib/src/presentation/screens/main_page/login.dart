import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';
import 'package:knittda/src/presentation/screens/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isWebLoginLoading = false;

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
                  onTap: _isWebLoginLoading ? null : () async {
                    setState(() {
                      _isWebLoginLoading = true;
                    });

                    try {
                      final success = await authVM.loginWithKakaoWeb();

                      if (!context.mounted) return;
                      
                      if (success) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const Home()),
                              (_) => false,
                        );
                      } else {
                        // 웹 로그인 실패 시 스낵바 표시
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('웹 로그인에 실패했습니다. 다시 시도해주세요.'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('로그인 중 오류가 발생했습니다: $e'),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    } finally {
                      if (mounted) {
                        setState(() {
                          _isWebLoginLoading = false;
                        });
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      color: _isWebLoginLoading ? Colors.grey[300] : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_isWebLoginLoading) ...[
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          _isWebLoginLoading ? '로그인 중...' : '웹으로 카카오 로그인',
                          style: TextStyle(
                            color: _isWebLoginLoading ? Colors.grey[600] : Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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