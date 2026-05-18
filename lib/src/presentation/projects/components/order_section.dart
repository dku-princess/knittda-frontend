import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/domain/util/project_order.dart';

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
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isInProgressSelected ? PRIMARY_COLOR : Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
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
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDoneSelected ? PRIMARY_COLOR : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
