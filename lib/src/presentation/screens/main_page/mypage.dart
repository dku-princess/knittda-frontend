import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Mypage extends StatelessWidget {
  const Mypage({super.key});

  static final Uri _url1 = Uri.parse('http://pf.kakao.com/_KDdNn/chat');
  static final Uri _url2 = Uri.parse(
    'https://fluffy-monarch-e7d.notion.site/service-guideline',
  );

  void onLogout(BuildContext context) async {
    await context.read<AuthViewModel>().logout();
  }

  void onSignout(BuildContext context) async {
    final ok = await context.read<AuthViewModel>().signout();

    if (!context.mounted) return;

    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('탈퇴에 실패했어요. 잠시 후 다시 시도해 주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();

    if (authVM.status == AuthStatus.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (authVM.status == AuthStatus.unauthenticated || authVM.user == null) {
      return const Scaffold(body: Center(child: Text('로그인이 필요합니다.')));
    }

    final user = authVM.user!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            '마이 페이지',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
                  backgroundImage:
                      user.profileImageUrl != null
                          ? NetworkImage(user.profileImageUrl!)
                          : null,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(width: 12),
                Text(user.nickname ?? '이름 없음', style: TextStyle(fontSize: 16)),
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

          //회원탈퇴
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: const Text('회원 탈퇴'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Text('회원탈퇴'),
                      content: Text('정말 탈퇴하시겠습니까?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text('취소'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),

                          child: Text(
                            '탈퇴',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
              );
              if (confirmed == true) {
                if (!context.mounted) return;
                onSignout(context);
              }
            },
          ),

          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: const Text('문의·신고'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              if (!await launchUrl(
                _url1,
                mode: LaunchMode.externalApplication,
              )) {
                throw Exception('Could not launch $_url1');
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
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () async {
                            if (!await launchUrl(
                              _url2,
                              mode: LaunchMode.externalApplication,
                            )) {
                              throw Exception('Could not launch $_url2');
                            }
                          },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}