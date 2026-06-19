import 'package:knittda/src/domain/model/project_previews.dart';

class ProjectPreviewsPage {
  final List<ProjectPreviews> content;
  final int number;
  final bool last;
  final int totalElements;

  const ProjectPreviewsPage({
    required this.content,
    required this.number,
    required this.last,
    required this.totalElements,
  });

  factory ProjectPreviewsPage.fromJson(Map<String, dynamic> json) {
    final rawContent = (json['content'] as List?) ?? const [];
    return ProjectPreviewsPage(
      content: rawContent
          .map((e) => ProjectPreviews.fromJson(e as Map<String, dynamic>))
          .toList(),
      number: (json['number'] as int?) ?? 0,
      last: (json['last'] as bool?) ?? true,
      totalElements: (json['totalElements'] as int?) ?? 0,
    );
  }
}
