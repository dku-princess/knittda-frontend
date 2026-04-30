import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:knittda/src/core/utils/markdown_utils.dart';
import 'package:knittda/src/domain/model/article/article_preview.dart';
import 'package:knittda/src/domain/model/article/project_section.dart';
import 'package:knittda/src/presentation/article_detail/components/article_preview_item.dart';

class ProjectSectionWidget extends StatelessWidget {
  final ProjectSection projectSection;
  final ArticlePreview? Function(int projectId) getArticlePreview;
  final void Function(int projectId)? onProjectTap;

  const ProjectSectionWidget({
    super.key,
    required this.projectSection,
    required this.getArticlePreview,
    this.onProjectTap,
  });

  @override
  Widget build(BuildContext context) {
    final validBlocks = projectSection.projectItemBlock
        .where((b) => getArticlePreview(b.projectId) != null)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (projectSection.title.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              projectSection.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
        ],

        if (projectSection.description.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child:
            MarkdownBody(
              data: normalizeMarkdown(
                projectSection.description,
              ),
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],

        if (validBlocks.isNotEmpty)
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: validBlocks.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final block = validBlocks[index];
                final preview = getArticlePreview(block.projectId)!;
                return SizedBox(
                  width: 180,
                  child: ArticlePreviewItem(
                    articlePreview: preview,
                    onTap: () => onProjectTap?.call(block.projectId),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
