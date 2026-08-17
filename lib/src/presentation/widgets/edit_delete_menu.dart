import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/knittda_dialog.dart';
import 'package:knittda/src/core/theme/theme.dart';

class EditDeleteMenu extends StatelessWidget {
  final VoidCallback onEdit;
  final Future<void> Function() onDelete;
  final String deleteDialogTitle;
  final String deleteDialogContent;

  const EditDeleteMenu({
    super.key,
    required this.onEdit,
    required this.onDelete,
    this.deleteDialogTitle = '삭제',
    this.deleteDialogContent = '정말 삭제하시겠습니까?',
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton <String>(
      icon: const Icon(Icons.more_vert, color: AppColors.black),

      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'edit',
          child: Text('수정'),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Text('삭제'),
        ),
      ],

      onSelected: (val) async {
        if(val == 'edit'){
          onEdit();
        } else if (val == 'delete') {
          final confirmed = await KnittdaDialog.confirm(
            context,
            title: deleteDialogTitle,
            message: deleteDialogContent,
            confirmLabel: '삭제',
            destructive: true,
          );
          if (confirmed == true) {
            await onDelete();
          }
        }
      },
    );
  }
}