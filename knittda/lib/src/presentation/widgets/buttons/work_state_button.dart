import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';

class WorkStateButton extends StatefulWidget {
  const WorkStateButton({super.key});

  @override
  State<WorkStateButton> createState() => _WorkStateButtonState();
}

class _WorkStateButtonState extends State<WorkStateButton> {
  final List<String> labels = ['뜨고 있어요', '다 떴어요'];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(labels.length, (index) {
        final isSelected = _selectedIndex == index;

        return TextButton(
          onPressed: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
          child: Text(
            labels[index],
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


