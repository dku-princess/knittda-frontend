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
        TextButton(
          onPressed: () {
            if (!isInProgressSelected) {
              onOrderChanged(const ProjectOrder.inProgress());
            }
          },
          child: Text(
            '뜨고 있어요',
            style: TextStyle(
              fontSize: 16,
              color: isInProgressSelected ? PRIMARY_COLOR : Colors.grey,
              decoration: isInProgressSelected
                  ? TextDecoration.underline
                  : TextDecoration.none,
              decorationColor: PRIMARY_COLOR,
            ),
          ),
        ),
        const SizedBox(width: 12),
        TextButton(
          onPressed: () {
            if (!isDoneSelected) {
              onOrderChanged(const ProjectOrder.done());
            }
          },
          child: Text(
            '다 떴어요',
            style: TextStyle(
              fontSize: 16,
              color: isDoneSelected ? PRIMARY_COLOR : Colors.grey,
              decoration: isDoneSelected
                  ? TextDecoration.underline
                  : TextDecoration.none,
              decorationColor: PRIMARY_COLOR,
            ),
          ),
        ),
      ],
    );
  }
}
