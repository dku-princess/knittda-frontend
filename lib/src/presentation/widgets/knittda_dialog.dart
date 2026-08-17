import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// Knittda 공통 다이얼로그 헬퍼.
///
/// 앱 전반의 `showDialog(AlertDialog(...))` 확인 다이얼로그를 통합한다.
/// 모서리·타이포·액션 색을 토큰으로 고정한다.
///
/// ```dart
/// final ok = await KnittdaDialog.confirm(
///   context,
///   title: '작품 삭제',
///   message: '정말 삭제하시겠습니까?',
///   confirmLabel: '삭제',
///   destructive: true,
/// );
/// if (ok) ...
/// ```
class KnittdaDialog {
  KnittdaDialog._();

  /// 취소/확인 2버튼 확인 다이얼로그. 확인=`true`, 취소·바깥탭=`false`.
  ///
  /// | 옵션 | 설명 |
  /// |---|---|
  /// | [title] | 제목 (필수). |
  /// | [message] | 본문(선택). |
  /// | [cancelLabel] | 취소 버튼 문구(기본 '취소'). |
  /// | [confirmLabel] | 확인 버튼 문구(기본 '확인'). |
  /// | [destructive] | true면 확인 버튼을 `error` 색(삭제·탈퇴 등). |
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    String? message,
    String cancelLabel = '취소',
    String confirmLabel = '확인',
    bool destructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          title: Text(title, style: AppTextStyles.heading),
          content: message == null
              ? null
              : Text(message, style: AppTextStyles.body),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(
                cancelLabel,
                style: AppTextStyles.body.copyWith(color: AppColors.textHint),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(
                confirmLabel,
                style: AppTextStyles.body.copyWith(
                  color: destructive ? AppColors.error : AppColors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }
}
