import 'package:flutter/material.dart';
import 'package:knittda/src/component/work_state_button.dart';
import 'package:knittda/src/component/work_list_item.dart';
import 'package:knittda/src/component/move_to_add_work_page_button.dart'; // 버튼 클래스 추가

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
          SizedBox(height: 20),
          WorkListItem(url: null, name: "모비스웨터", date: "3일전"),
          SizedBox(height: 20), // 버튼과 리스트 아이템 간 간격 추가
          MoveToAddWorkPageButton(), // +버튼 추가
        ],
      ),
    );
  }
}
