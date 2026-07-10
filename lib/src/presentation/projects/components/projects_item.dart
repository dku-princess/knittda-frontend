import 'package:flutter/material.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/core/theme/theme.dart';

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
        border: Border(bottom: BorderSide(color: AppColors.grey200, width: 1)),
      ),

      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.card),
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
                            color: AppColors.grey200,
                            child: Icon(Icons.broken_image, color: AppColors.grey400),
                          );
                        },
                      )
                    : Container(
                        width: 60,
                        height: 60,
                        color: AppColors.grey200,
                        child: Icon(Icons.image_outlined, color: AppColors.grey400),
                      ),
              ),

              SizedBox(width: AppSpacing.space12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.nickname,
                      style: TextStyle(
                        fontSize: AppFontSize.lg,
                        fontWeight: AppFontWeight.medium,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: AppSpacing.space16),

                    Row(
                      children: [
                        Text(
                          "기록일",
                          style: TextStyle(
                            fontSize: AppFontSize.sm,
                            color: AppColors.grey600,
                          ),
                        ),
                        SizedBox(width: AppSpacing.space4),
                        Text(
                          lastRecordAt,
                          style: TextStyle(
                            fontSize: AppFontSize.sm,
                            color: AppColors.grey600,
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
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '추가',
                    style: TextStyle(
                      color: AppColors.grey400,
                      fontSize: AppFontSize.md,
                      fontWeight: AppFontWeight.medium,
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
