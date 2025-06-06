import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';

class WorkStateButton extends StatefulWidget {
  final String selectedStatus;
  final ValueChanged<String> onChanged;

  const WorkStateButton({
    super.key,
    required this.selectedStatus,
    required this.onChanged,
  });

  @override
  State<WorkStateButton> createState() => _WorkStateButtonState();
}

class _WorkStateButtonState extends State<WorkStateButton> {
  final List<Map<String, String>> states = [
    {'label': '뜨고 있어요', 'status': 'IN_PROGRESS'},
    {'label': '다 떴어요', 'status': 'DONE'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(states.length, (index) {
        final status = states[index]['status']!;
        final label = states[index]['label']!;
        final isSelected = widget.selectedStatus == status;

        return TextButton(
          onPressed: () => widget.onChanged(status),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? PRIMARY_COLOR : Colors.grey,
              decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
              decorationColor: PRIMARY_COLOR,
            ),
          ),
        );
      }),
    );
  }
}



