import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/knittda_snack_bar.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/markdown_utils.dart';
import 'package:knittda/src/domain/model/article/purchase_link_section.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:knittda/src/core/theme/theme.dart';

class PurchaseLinkSectionWidget extends StatelessWidget {
  final PurchaseLinkSection purchaseLinkSection;

  /// 구매 버튼 탭 시점 (URL launch 시도 직전). pattern_link_click 발화용.
  final VoidCallback? onPatternLinkClick;

  /// 외부 URL 오픈 성공 시점. external_pattern_page_open 발화용.
  final VoidCallback? onExternalPatternPageOpen;

  const PurchaseLinkSectionWidget({
    super.key,
    required this.purchaseLinkSection,
    this.onPatternLinkClick,
    this.onExternalPatternPageOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (purchaseLinkSection.title.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space20),
            child: Text(
              purchaseLinkSection.title,
              style: AppTextStyles.title,
            ),
          ),
        ],

        if (purchaseLinkSection.description != null &&
            purchaseLinkSection.description!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space20),
            child: MarkdownBody(
              data: normalizeMarkdown(purchaseLinkSection.description!),
              styleSheet: MarkdownStyleSheet(
                p: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
              ),
            ),
          ),
        ],

        if (purchaseLinkSection.buttonUrl.isNotEmpty &&
            purchaseLinkSection.buttonText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space24),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  // 클릭은 launch 성공/실패와 무관하게 종착 지표로 먼저 기록
                  onPatternLinkClick?.call();
                  try {
                    final url = Uri.parse(purchaseLinkSection.buttonUrl);
                    if (!await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    )) {
                      if (context.mounted) {
                        KnittdaSnackBar.show(context, '링크를 열 수 없습니다.', tone: KnittdaSnackTone.error);
                      }
                    } else {
                      // launch 성공 시에만 외부 이동 정합 이벤트 발화
                      onExternalPatternPageOpen?.call();
                    }
                  } catch (e) {
                    debugPrint(
                      'Failed to launch URL: ${purchaseLinkSection.buttonUrl}, error: $e',
                    );
                    if (context.mounted) {
                      KnittdaSnackBar.show(context, '링크를 열 수 없습니다.', tone: KnittdaSnackTone.error);
                    }
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: PRIMARY_COLOR,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.space12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                ),
                child: Text(
                  purchaseLinkSection.buttonText,
                  style: AppTextStyles.bodyStrong.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
