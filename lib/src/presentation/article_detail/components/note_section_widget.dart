import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:knittda/src/core/utils/markdown_utils.dart';
import 'package:knittda/src/domain/model/article/note_section.dart';
import 'package:url_launcher/url_launcher.dart';

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
        if (noteSection.noteItemBlock != null) ...[
          MarkdownBody(
            data: normalizeMarkdown(noteSection.noteItemBlock!),
            onTapLink: (text, href, title) async {
              if (href == null) return;

              final uri = Uri.parse(href);
              if (uri.pathSegments.contains('articles') &&
                  uri.pathSegments.length >= 2) {
                final slug = uri.pathSegments.last;
                onArticleTap?.call(slug);
              } else {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            styleSheet: MarkdownStyleSheet(
              p: const TextStyle(fontSize: 14),
              a: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (noteSection.copyrightItemBlock != null)
          MarkdownBody(
            data: normalizeMarkdown(noteSection.copyrightItemBlock!),
            onTapLink: (text, href, title) async {
              if (href == null) return;
              final url = Uri.parse(href);
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('링크를 열 수 없습니다.')),
                  );
                }
              }
            },
            styleSheet: MarkdownStyleSheet(
              p: const TextStyle(fontSize: 12, color: Colors.black54),
              a: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
      ],
    );
  }
}
