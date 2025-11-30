import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:knittda/src/domain/use_case/admin_login_use_case.dart';
import 'package:knittda/src/domain/use_case/auto_login_use_case.dart';
import 'package:knittda/src/domain/use_case/social_login_use_case.dart';
import 'package:knittda/src/presentation/login/login_screen.dart';
import 'package:knittda/src/presentation/login/login_view_model.dart';
import 'package:knittda/src/presentation/mypage/mypage_event.dart';
import 'package:knittda/src/presentation/mypage/mypage_ui_event.dart';
import 'package:knittda/src/presentation/mypage/mypage_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  static final Uri _url1 = Uri.parse('http://pf.kakao.com/_KDdNn/chat');
  static final Uri _url2 = Uri.parse(
    'https://fluffy-monarch-e7d.notion.site/service-guideline',
  );

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        final viewModel = context.read<MypageViewModel>();

        _subscription = viewModel.eventStream.listen((event) {
          if (mounted) {
            switch (event) {
              case Completed():
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) =>
                        ChangeNotifierProvider<LoginViewModel>(
                          create: (context) => LoginViewModel(
                            context.read<AutoLoginUseCase>(),
                            context.read<SocialLoginUseCase>(),
                            context.read<AdminLoginUseCase>(),
                          ),
                          child: const LoginScreen(),
                        ),
                  ),
                  (route) => false,
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

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MypageViewModel>();
    final state = viewModel.state;
    final user = state.user;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            '마이페이지',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 20, right: 20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      (user?.profileImageUrl != null &&
                          user!.profileImageUrl!.isNotEmpty)
                      ? NetworkImage(user.profileImageUrl!)
                      : null,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(width: 12),
                Text(
                  user?.nickname ?? '알 수 없는 사용자',
                  style: const TextStyle(fontSize: 16),
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
            onTap: () {
              viewModel.onEvent(MypageEvent.logout());
            },
          ),

          //회원탈퇴
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: const Text('회원 탈퇴'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('회원탈퇴'),
                  content: Text('정말 탈퇴하시겠습니까?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('취소'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),

                      child: Text('탈퇴', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
              if (confirmed == true) {
                viewModel.onEvent(MypageEvent.signout());
              }
            },
          ),

          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: const Text('문의·신고'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              if (!await launchUrl(
                MypageScreen._url1,
                mode: LaunchMode.externalApplication,
              )) {
                throw Exception('Could not launch ${MypageScreen._url1}');
              }
            },
          ),

          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '서비스 이용약관 및 커뮤니티 운영정책',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.grey,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        if (!await launchUrl(
                          MypageScreen._url2,
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw Exception(
                            'Could not launch ${MypageScreen._url2}',
                          );
                        }
                      },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              '1.0.0',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
