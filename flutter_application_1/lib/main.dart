import 'package:flutter/material.dart';
import 'screens/WorkList.dart';
import 'screens/MyPage.dart';
import 'screens/MoreMenuPage.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatefulWidget {
  const FigmaToCodeApp({super.key});

  @override
  _FigmaToCodeAppState createState() => _FigmaToCodeAppState();
}

class _FigmaToCodeAppState extends State<FigmaToCodeApp> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    WorkList(),
    MyPage(),
    MoreMenuPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: const <BottomNavigationBarItem>[
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
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: const Color(0xFF00A367), // #00A367 색상 적용
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Colors.white,
                  onTap: _onItemTapped,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

