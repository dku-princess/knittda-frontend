import 'package:flutter/material.dart';
import 'package:knittda/src/component/work_state_button.dart';

class WorkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            '나의\n뜨개 작품',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          WorkStateButton(),
        ],
      ),
    );
  }
}