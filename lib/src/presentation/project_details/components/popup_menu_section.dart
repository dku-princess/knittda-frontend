import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/knittda_dialog.dart';

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
    final confirm = await KnittdaDialog.confirm(
      context,
      title: deleteDialogTitle,
      message: deleteDialogContent,
      confirmLabel: '삭제',
      destructive: true,
    );
    if (confirm) {
      await onDelete();
    }
  }
}
