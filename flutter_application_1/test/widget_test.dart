// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aplication_1/main.dart';
import 'package:flutter_aplication_1/screens/WorkList.dart';
import 'package:flutter_aplication_1/screens/MyPage.dart';
import 'package:flutter_aplication_1/screens/MoreMenuPage.dart';

void main() {
  testWidgets('BottomNavigationBar 위젯 테스트', (WidgetTester tester) async {
    // 앱 빌드 및 프레임 트리거
    await tester.pumpWidget(const FigmaToCodeApp());

    // 첫 화면 (WorkList) 확인
    expect(find.byType(WorkList), findsOneWidget);

    // 네비게이션 바 버튼 클릭 후 화면 전환 테스트
    await tester.tap(find.text('마이페이지'));
    await tester.pumpAndSettle();
    expect(find.byType(MyPage), findsOneWidget);

    await tester.tap(find.text('더보기'));
    await tester.pumpAndSettle();
    expect(find.byType(MoreMenuPage), findsOneWidget);

    // 네비게이션 바 버튼 색상 테스트
    BottomNavigationBarItem pencilItem = const BottomNavigationBarItem(
      icon: Icon(Icons.edit_note),
      label: '연필',
    );
    expect(pencilItem.icon, isNotNull);

    // 추가적인 테스트 요소
    // ...
  });
}

