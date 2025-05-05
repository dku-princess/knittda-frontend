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
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true, //appbar 고정
                expandedHeight: 210.0, //확장 높이
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {},
                ),
                flexibleSpace: FlexibleSpaceBar(
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
                  indicatorColor: Colors.black87,
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
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