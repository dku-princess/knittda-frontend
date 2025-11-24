import 'package:flutter/material.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/core/utils/date_utils.dart';

class ProjectsItem extends StatelessWidget {
  final Project project;
  const ProjectsItem({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final String lastRecordAt = DateUtilsHelper.getRelativeDate(project.lastRecordAt);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child:
              (project.thumbnailUrl != null && project.thumbnailUrl!.isNotEmpty)
              ? Image.network(
                  project.thumbnailUrl!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    );
                  },
                )
              : Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: Icon(Icons.image_outlined, color: Colors.grey),
                ),
        ),

        SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.nickname!,
                style: TextStyle(fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 16),

              Row(
                children: [
                  Text(
                    "기록일",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  SizedBox(width: 4),
                  Text(
                    lastRecordAt,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),

        TextButton(
          onPressed: () {

          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[300],
            minimumSize: const Size(0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            '추가',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ),

      ],
    );
  }
}
