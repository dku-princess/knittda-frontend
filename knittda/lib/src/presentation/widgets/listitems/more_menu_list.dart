import 'package:flutter/material.dart';

class MoreMenuList extends StatelessWidget {
  final String title;
  final VoidCallback onTab;

  MoreMenuList({
    required this.title,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 24.0, right: 24.0),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: onTab,
    );
  }
}