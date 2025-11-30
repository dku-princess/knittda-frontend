import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/presentation/feed/feed_screen.dart';
import 'package:knittda/src/presentation/project_previews/project_previews_screen.dart';
import 'package:knittda/src/presentation/projects/projects_screen.dart';
//import 'package:knittda/src/presentation/screens/main_page/mypage.dart';

// 바텀네비게이션 리스트
final List<BottomNavigationBarItem> myTabs = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home_filled),
    label: '홈',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.search_outlined),
    label: '작품',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.watch_later_outlined),
    label: '피드',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: '마이페이지',
  ),
];

//바텀네비게이션 클릭 시 이동할 페이지 목록
final List<Widget> _widgetOptions = <Widget>[
  const ProjectsScreen(),
  const ProjectPreviewsScreen(),
  const FeedScreen(),
  const Center(child: Text('마이페이지')),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: myTabs,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
    );
  }
}
