import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/knittda_dialog.dart';
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
    final confirm = await KnittdaDialog.confirm(
      context,
      title: '작품 삭제',
      message: '정말 삭제하시겠습니까?',
      confirmLabel: '삭제',
      destructive: true,
    );
    if (confirm == true) {
      await onDelete();
    }
  }
}
