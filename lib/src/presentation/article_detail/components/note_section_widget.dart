import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/knittda_snack_bar.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:knittda/src/core/utils/markdown_utils.dart';
import 'package:knittda/src/domain/model/article/note_section.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:knittda/src/core/theme/theme.dart';

class NoteSectionWidget extends StatelessWidget {
  final NoteSection noteSection;
  final void Function(String slugOrId)? onArticleTap;

  const NoteSectionWidget({
    super.key,
    required this.noteSection,
    this.onArticleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (noteSection.noteItemBlock != null &&
            noteSection.noteItemBlock!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space16),
            child: MarkdownBody(
              data: normalizeMarkdown(noteSection.noteItemBlock!),
              onTapLink: (text, href, title) async {
                if (href == null) return;

                final uri = Uri.parse(href);
                final segments = uri.pathSegments;
                final articleIndex = segments.indexOf('articles');
                if (articleIndex != -1 && articleIndex + 1 < segments.length) {
                  final slug = segments[articleIndex + 1];
                  onArticleTap?.call(slug);
                }
              },
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(fontSize: AppFontSize.md),
                a: const TextStyle(
                  fontSize: AppFontSize.md,
                  color: AppColors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],

        if (noteSection.copyrightItemBlock != null &&
            noteSection.copyrightItemBlock!.isNotEmpty)
          MarkdownBody(
            data: normalizeMarkdown(noteSection.copyrightItemBlock!),
            onTapLink: (text, href, title) async {
              if (href == null) return;
              try {
                final url = Uri.parse(href);
                if (!await launchUrl(
                  url,
                  mode: LaunchMode.externalApplication,
                )) {
                  if (context.mounted) {
                    KnittdaSnackBar.show(context, '링크를 열 수 없습니다.', tone: KnittdaSnackTone.error);
                  }
                }
              } catch (e) {
                debugPrint('Failed to launch URL: $href, error: $e');
                if (context.mounted) {
                  KnittdaSnackBar.show(context, '링크를 열 수 없습니다.', tone: KnittdaSnackTone.error);
                }
              }
            },
            styleSheet: MarkdownStyleSheet(
              p: const TextStyle(fontSize: AppFontSize.sm, color: AppColors.textSecondary),
              a: const TextStyle(
                fontSize: AppFontSize.sm,
                color: AppColors.textSecondary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
      ],
    );
  }
}
