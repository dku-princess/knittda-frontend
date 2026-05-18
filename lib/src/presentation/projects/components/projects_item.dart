import 'package:flutter/material.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/core/utils/date_utils.dart';

class ProjectsItem extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;
  final VoidCallback onPressed;
  const ProjectsItem({
    super.key,
    required this.project,
    required this.onTap,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final String lastRecordAt = DateUtilsHelper.getRelativeDate(
      project.lastRecordAt,
    );

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE6E6E6), width: 1)),
      ),

      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                    (project.thumbnailUrl != null &&
                        project.thumbnailUrl!.isNotEmpty)
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

              SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.nickname,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 16),

                    Row(
                      children: [
                        Text(
                          "기록일",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          lastRecordAt,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onPressed,
                child: Container(
                  width: 45,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '추가',
                    style: TextStyle(
                      color: Color(0xFFA6A6A6),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
