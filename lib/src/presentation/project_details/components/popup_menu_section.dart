import 'package:flutter/material.dart';

class PopupMenuSection extends StatelessWidget {
  final VoidCallback onEdit;
  final Future<void> Function() onDelete;
  final String deleteDialogTitle;
  final String deleteDialogContent;
  const PopupMenuSection({
    super.key,
    required this.onEdit,
    required this.onDelete,
    this.deleteDialogTitle = '작품 삭제',
    this.deleteDialogContent = '정말 삭제하시겠습니까?',
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
          title: Text(deleteDialogTitle),
          content: Text(deleteDialogContent),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('삭제', style: TextStyle(color: Colors.red)),
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
