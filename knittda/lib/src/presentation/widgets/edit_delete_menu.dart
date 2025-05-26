import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditDeleteMenu extends StatelessWidget {
  final VoidCallback onEdit;
  final Future<void> Function() onDelete;

  const EditDeleteMenu({
    Key? key,
    required this.onEdit,
    required this.onDelete,
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
              title: Text('기록 삭제'),
              content: Text('정말 이 기록을 삭제하시겠습니까?'),
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