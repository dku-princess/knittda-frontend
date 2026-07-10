import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/knittda_app_bar.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/presentation/mypage_setting_nickname/mypage_setting_nickname_event.dart';
import 'package:knittda/src/presentation/mypage_setting_nickname/mypage_setting_nickname_view_model.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/presentation/mypage_setting_nickname/mypage_setting_nickname_ui_event.dart';
import 'package:knittda/src/core/theme/theme.dart';

class MypageSettingNicknameScreen extends StatefulWidget {
  const MypageSettingNicknameScreen({super.key});

  @override
  State<MypageSettingNicknameScreen> createState() =>
      _MypageSettingNicknameScreenState();
}

class _MypageSettingNicknameScreenState
    extends State<MypageSettingNicknameScreen> {
  StreamSubscription? _subscription;

  final _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        final viewModel = context.read<MypageSettingNicknameViewModel>();

        _subscription = viewModel.eventStream.listen((event) {
          if (mounted) {
            switch (event) {
              case SetNickname():
                Navigator.pop(context);
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
    final viewModel = context.watch<MypageSettingNicknameViewModel>();
    final isLoading = viewModel.state.isLoading;

    return PopScope(
      canPop: !isLoading,
      child: Scaffold(
        appBar: KnittdaAppBar(
          title: '닉네임 설정',
          actions: [
            //저장버튼
            TextButton(
              onPressed: isLoading
                  ? null
                  : () {
                      final nickname = _nicknameController.text.trim();
                      if (nickname.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('닉네임을 입력해주세요.')),
                        );
                        return;
                      }
                      context.read<MypageSettingNicknameViewModel>().onEvent(
                        SettingNickname(nickname),
                      );
                    },
              style: TextButton.styleFrom(
                backgroundColor: PRIMARY_COLOR,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.card),
                ),
              ),
              child: const Text('저장', style: TextStyle(fontSize: AppFontSize.lg)),
            ),
            const SizedBox(width: AppSpacing.space8),
          ],
        ),

        body: Padding(
          padding: EdgeInsets.all(AppSpacing.space20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "닉네임",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: AppFontSize.lg,
                  fontWeight: AppFontWeight.medium,
                ),
              ),
              SizedBox(height: AppSpacing.space12),
              TextField(
                maxLines: 1,
                maxLength: 8,
                controller: _nicknameController,
                enabled: !isLoading,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.button),
                  ),
                ),
                style: const TextStyle(fontSize: AppFontSize.md),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
