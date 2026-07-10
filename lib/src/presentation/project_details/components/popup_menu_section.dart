import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

class PopupMenuSection extends StatelessWidget {
  final VoidCallback onEdit;
  final Future<void> Function() onDelete;
  const PopupMenuSection({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'edit', child: Text('수정')),
        const PopupMenuItem(value: 'delete', child: Text('삭제')),
      ],

      onSelected: (value) {
        switch (value) {
          case 'edit':
            onEdit();
            break;
          case 'delete':
            _onDelete(context);
            break;
        }
      },
    );
  }

  Future<void> _onDelete(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('작품 삭제'),
          content: const Text('정말 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('삭제', style: TextStyle(color: AppColors.error)),
            ),
          ],
        );
      },
    );
    if (confirm == true) {
      await onDelete();
    }
  }
}
