import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:knittda/src/domain/repository/announcement_repository.dart';
import 'package:knittda/src/domain/repository/authentication_repository.dart';
import 'package:knittda/src/domain/use_case/auto_login_use_case.dart';
import 'package:knittda/src/domain/use_case/get_announcement_use_case.dart';
import 'package:knittda/src/domain/use_case/get_user_use_case.dart';
import 'package:knittda/src/domain/use_case/setting_nickname_use_case.dart';
import 'package:knittda/src/domain/use_case/social_login_use_case.dart';
import 'package:knittda/src/presentation/announcement/announcement_screen.dart';
import 'package:knittda/src/presentation/announcement/announcement_view_model.dart';
import 'package:knittda/src/presentation/login/login_screen.dart';
import 'package:knittda/src/presentation/login/login_view_model.dart';
import 'package:knittda/src/presentation/mypage/mypage_event.dart';
import 'package:knittda/src/presentation/mypage/mypage_ui_event.dart';
import 'package:knittda/src/presentation/mypage/mypage_view_model.dart';
import 'package:knittda/src/presentation/mypage_setting_nickname/mypage_setting_nickname_screen.dart';
import 'package:knittda/src/presentation/mypage_setting_nickname/mypage_setting_nickname_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

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

  final ImagePicker picker = ImagePicker();

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
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ChangeNotifierProvider<LoginViewModel>(
                          create: (context) => LoginViewModel(
                            context.read<AutoLoginUseCase>(),
                            context.read<SocialLoginUseCase>(),
                            context.read<GetUserUseCase>(),
                          ),
                          child: const LoginScreen(),
                        ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            child,
                    transitionDuration: Duration.zero,
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

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 70,
    );

    if (!mounted) return;

    if (picked != null) {
      context.read<MypageViewModel>().onEvent(SettingProfileImage(picked));
    }
  }

  Future<void> _showSettingProfileSheet() async {
    final action = await showModalBottomSheet<String>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('닉네임 설정'),
                onTap: () => Navigator.pop(sheetContext, 'nickname'),
              ),
              ListTile(
                title: const Text('프로필 이미지 설정'),
                onTap: () => Navigator.pop(sheetContext, 'image'),
              ),
            ],
          ),
        );
      },
    );

    // sheet가 닫힌 후 여기서 처리
    if (!mounted || action == null) return;

    switch (action) {
      case 'nickname':
        await _nicknameSetting();
      case 'image':
        await _pickImage();
    }
  }

  // 닉네임 설정 화면 이동을 별도 메서드로 분리
  Future<void> _nicknameSetting() async {
    final viewModel = context.read<MypageViewModel>();
    final user = viewModel.state.user;
    if (user == null) return;

    await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        settings: const RouteSettings(name: 'mypage_nickname'),
        builder: (context) => ChangeNotifierProvider(
          create: (context) => MypageSettingNicknameViewModel(
            SettingNicknameUseCase(context.read<AuthenticationRepository>()),
            user: user,
          ),
          child: const MypageSettingNicknameScreen(),
        ),
      ),
    );
  }

  Future<void> _launchExternalUrl(Uri url) async {
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('링크를 열 수 없습니다.')));
        }
      }
    } catch (e) {
      debugPrint('Failed to launch URL: $url, error: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('링크를 열 수 없습니다.')));
      }
    }
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
        title: const Text(
          '마이페이지',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        titleSpacing: 30,
      ),

      body: ListView(
        children: [
          SizedBox(height: 20),

          Container(
            padding: EdgeInsets.only(top: 8, bottom: 24, left: 30, right: 30),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFF5F7F8), width: 3),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: state.previewImage != null
                      ? FileImage(File(state.previewImage!.path)) // 미리보기 우선
                      : (user?.profileImageUrl != null &&
                            user!.profileImageUrl!.isNotEmpty)
                      ? NetworkImage(user.profileImageUrl!)
                      : null,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(width: 20),
                Text(
                  user?.nickname ?? '알 수 없는 사용자',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 28),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('나의 계정정보'),
                _buildMenuItem(
                  '회원정보 수정',
                  onTap: () {
                    if (user == null) return;
                    _showSettingProfileSheet();
                  },
                ),
                _buildMenuItem(
                  '로그아웃',
                  onTap: () {
                    viewModel.onEvent(MypageEvent.logout());
                  },
                ),
                _buildMenuItem(
                  '회원탈퇴',
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

                            child: Text(
                              '탈퇴',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      viewModel.onEvent(MypageEvent.signout());
                    }
                  },
                ),

                SizedBox(height: 40),

                _buildSectionHeader('문의'),
                _buildMenuItem(
                  '공지사항',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        settings: const RouteSettings(name: 'announcement'),
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => AnnouncementViewModel(
                            GetAnnouncementUseCase(
                              context.read<AnnouncementRepository>(),
                            ),
                          ),
                          child: const AnnouncementScreen(),
                        ),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  '고객센터',
                  onTap: () async {
                    await _launchExternalUrl(MypageScreen._url1);
                  },
                ),
                _buildMenuItem(
                  '개인정보 처리방침',
                  onTap: () async {
                    await _launchExternalUrl(MypageScreen._url2);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 섹션 헤더 위젯
Widget _buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.only(bottom: 12),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFF4D4D4D), width: 1)),
    ),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF4D4D4D),
      ),
    ),
  );
}

// 메뉴 아이템 위젯
Widget _buildMenuItem(String title, {required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE6E6E6), width: 0.5),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF4D4D4D),
        ),
      ),
    ),
  );
}
