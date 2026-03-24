import 'package:flutter/material.dart';
import 'package:knittda/src/domain/model/article/project_section.dart';
import 'package:knittda/src/domain/model/project_previews.dart';
import 'package:knittda/src/presentation/project_previews/components/project_previews_item.dart';

class ProjectSectionWidget extends StatelessWidget {
  final ProjectSection projectSection;
  final ProjectPreviews? Function(int projectId) getProjectPreview;
  final void Function(int projectId)? onProjectTap;

  const ProjectSectionWidget({
    super.key,
    required this.projectSection,
    required this.getProjectPreview,
    this.onProjectTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          projectSection.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),

        if (projectSection.description.isNotEmpty) ...[
          SizedBox(height: 16),
          Text(
            projectSection.description,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],

        SizedBox(height: 16),

        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: projectSection.projectItemBlock.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final block = projectSection.projectItemBlock[index];
              final preview = getProjectPreview(block.projectId);
              if (preview == null) return const SizedBox.shrink();
              return SizedBox(
                width: 180,
                child: ProjectPreviewsItem(
                  projectPreviews: preview,
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
