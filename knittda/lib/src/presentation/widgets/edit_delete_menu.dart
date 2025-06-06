import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditDeleteMenu extends StatelessWidget {
  final VoidCallback onEdit;
  final Future<void> Function() onDelete;
  final String deleteDialogTitle;
  final String deleteDialogContent;

  const EditDeleteMenu({
    Key? key,
    required this.onEdit,
    required this.onDelete,
    this.deleteDialogTitle = '삭제',
    this.deleteDialogContent = '정말 삭제하시겠습니까?',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton <String>(
      icon: const Icon(Icons.more_vert, color: Colors.black),

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
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(deleteDialogTitle),
              content: Text(deleteDialogContent),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('취소'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('삭제', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
          if (confirmed == true) {
            await onDelete();
          }
        }
      },
    );
  }
}