import 'package:flutter/material.dart';
import 'package:knittda/src/widgets/buttons/work_state_button.dart';
import 'package:knittda/src/widgets/listitems/work_list_item.dart';

final List<Widget> worklist = <Widget>[
  WorkListItem(url: null, name: "벤쿠버 가디건", date: "3일전"),
  WorkListItem(url: null, name: "블랙베리 아란 스웨터", date: "3일전"),
  WorkListItem(url: null, name: "브이넥 조끼", date: "3일전"),
];

class WorkList extends StatelessWidget {
  const WorkList({super.key});

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            WorkStateButton(),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: worklist.length + 1,
                itemBuilder: (context, index){
                  if(index < worklist.length){
                    final list = worklist[index];
                    return list;
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: double.infinity,
                        height: 36,
                        child: TextButton(
                          onPressed: () {
                            // 버튼 클릭 동작
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
