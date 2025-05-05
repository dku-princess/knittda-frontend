import 'package:flutter/material.dart';
import 'package:knittda/src/widgets/image_box.dart';

final List<Tab> myTabs = <Tab>[
  Tab(text:'정보'),
  Tab(text:'다이어리'),
  Tab(text:'리포트'),
];

final List<Widget> myTabItems = [
  Center(child: Text('정보'),),
  Center(child: Text('다이어리'),),
  Center(child: Text('리포트'),),
];

class WorkDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top; //상태바 높이

    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true, //appbar 고정
                expandedHeight: 210.0, //확장 높이
                backgroundColor: Colors.white, //배경 흰색
                leading: IconButton( //뒤로가기 버튼
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {},
                ),
                flexibleSpace: FlexibleSpaceBar( //확장영역
                  background: Padding(
                    padding: EdgeInsets.only(top: topPadding + 56, left: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageBox(null, size: 100),
                        SizedBox(width: 16),
                        Text(
                          'test',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: TabBar(
                  indicatorColor: Colors.black87, //tabbar 밑줄 색상
                  labelColor: Colors.black87, //선택된 영역 글자 색
                  unselectedLabelColor: Colors.grey, //선택 안된 영역 글자색
                  tabs: myTabs,
                ),
              ),
            ];
          },
          body: TabBarView(children: myTabItems),
        ),
      ),
    );
  }
}