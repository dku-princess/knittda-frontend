import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/domain/util/project_order.dart';
import 'package:knittda/src/core/theme/theme.dart';

class OrderSection extends StatelessWidget {
  final ProjectOrder projectOrder;
  final ValueChanged<ProjectOrder> onOrderChanged;

  const OrderSection({
    super.key,
    required this.projectOrder,
    required this.onOrderChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isInProgressSelected = projectOrder is InProgress;
    final bool isDoneSelected = projectOrder is Done;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (!isInProgressSelected) {
              onOrderChanged(const ProjectOrder.inProgress());
            }
          },
          child: Container(
            padding: const EdgeInsets.only(bottom: 3),
            decoration: isInProgressSelected
                ? BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: PRIMARY_COLOR, width: 1),
                    ),
                  )
                : null,
            child: Text(
              '뜨고 있어요',
              style: TextStyle(
                fontSize: AppFontSize.md,
                fontWeight: AppFontWeight.medium,
                color: isInProgressSelected ? PRIMARY_COLOR : AppColors.grey400,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.space32),
        GestureDetector(
          onTap: () {
            if (!isDoneSelected) {
              onOrderChanged(const ProjectOrder.done());
            }
          },
          child: Container(
            padding: const EdgeInsets.only(bottom: 3),
            decoration: isDoneSelected
                ? BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: PRIMARY_COLOR, width: 1),
                    ),
                  )
                : null,
            child: Text(
              '다 떴어요',
              style: TextStyle(
                fontSize: AppFontSize.md,
                fontWeight: AppFontWeight.medium,
                color: isDoneSelected ? PRIMARY_COLOR : AppColors.grey400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
