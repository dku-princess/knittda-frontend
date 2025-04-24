import 'package:flutter/material.dart';
import 'package:knittda/src/constants/color.dart';

import 'work_list.dart';
import 'more_menu.dart';
import 'mypage.dart';

final List<BottomNavigationBarItem> myTabs = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.edit_note), // 텍스트 제거
    label: '',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person), // 텍스트 제거
    label: '',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.menu), // 텍스트 제거
    label: '',
  ),
];

final List<Widget> _widgetOptions = <Widget>[
  WorkList(),
  Mypage(),
  MoreMenu(),
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
