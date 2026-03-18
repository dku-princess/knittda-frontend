import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/presentation/mypage_setting_nick_name/mypage_setting_nick_name_event.dart';
import 'package:knittda/src/presentation/mypage_setting_nick_name/mypage_setting_nick_name_view_model.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/presentation/mypage_setting_nick_name/mypage_setting_nick_name_ui_event.dart';

class MypageSettingNickNameScreen extends StatefulWidget {
  const MypageSettingNickNameScreen({super.key});

  @override
  State<MypageSettingNickNameScreen> createState() =>
      _MypageSettingNickNameScreenState();
}

class _MypageSettingNickNameScreenState
    extends State<MypageSettingNickNameScreen> {
  StreamSubscription? _subscription;

  final _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        final viewModel = context.read<MypageSettingNickNameViewModel>();

        _subscription = viewModel.eventStream.listen((event) {
          if (mounted) {
            switch (event) {
              case SetNickName():
                Navigator.pop(context, true);
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
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          '닉네임 설정',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          //저장버튼
          TextButton(
            onPressed: () {
              final nickname = _nicknameController.text.trim();
              if (nickname.isEmpty) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('닉네임을 입력해주세요.')));
                return;
              }
              context.read<MypageSettingNickNameViewModel>().onEvent(
                SettingNickName(nickname),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('저장', style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "닉네임",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            TextField(
              maxLines: 1,
              maxLength: 8,
              controller: _nicknameController,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
