import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';

class ProgressSection extends StatelessWidget {
  final String status;
  final VoidCallback onPressed;

  const ProgressSection({
    super.key,
    required this.status,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final label = switch (status) {
      'IN_PROGRESS' => '뜨고 있어요',
      'DONE' => '다 떴어요',
      _ => '뜨고 있어요',
    };

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: PRIMARY_COLOR),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Text(label, style: TextStyle(color: PRIMARY_COLOR)),
    );
  }
}
