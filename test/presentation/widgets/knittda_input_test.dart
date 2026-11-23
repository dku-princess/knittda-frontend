import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:knittda/src/presentation/widgets/knittda_input.dart';

Widget _wrap(Widget child) {
  return MaterialApp(home: Scaffold(body: child));
}

void main() {
  group('KnittdaInput maxLength 동작', () {
    testWidgets('onMaxLengthExceeded가 있으면 글자수 카운터를 숨긴다', (tester) async {
      await tester.pumpWidget(
        _wrap(KnittdaInput(maxLength: 30, onMaxLengthExceeded: () {})),
      );

      expect(find.textContaining('/30'), findsNothing);
    });

    testWidgets('onMaxLengthExceeded가 없으면 기존처럼 카운터를 보여준다 (하위 호환)', (
      tester,
    ) async {
      await tester.pumpWidget(_wrap(KnittdaInput(maxLength: 8)));

      expect(find.text('0/8'), findsOneWidget);
    });

    testWidgets('maxLength를 넘는 입력은 잘려서 들어간다', (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        _wrap(
          KnittdaInput(
            controller: controller,
            maxLength: 30,
            onMaxLengthExceeded: () {},
          ),
        ),
      );

      final overLong = 'ㄱ' * 40;
      await tester.enterText(find.byType(TextFormField), overLong);
      await tester.pump();

      expect(controller.text.length, 30);
    });

    testWidgets('maxLength를 넘겨 입력을 시도하면 onMaxLengthExceeded가 호출된다', (
      tester,
    ) async {
      var exceededCount = 0;
      final controller = TextEditingController();
      await tester.pumpWidget(
        _wrap(
          KnittdaInput(
            controller: controller,
            maxLength: 30,
            onMaxLengthExceeded: () => exceededCount++,
          ),
        ),
      );

      // 한도(30자) 이내 입력에서는 호출되지 않아야 한다.
      await tester.enterText(find.byType(TextFormField), 'ㄱ' * 30);
      await tester.pump();
      expect(exceededCount, 0);

      // 한도를 넘는 입력을 시도하면 호출돼야 한다.
      await tester.enterText(find.byType(TextFormField), 'ㄱ' * 40);
      await tester.pump();
      expect(exceededCount, greaterThan(0));
    });

    testWidgets('maxLength 이내 입력에서는 onMaxLengthExceeded가 호출되지 않는다', (
      tester,
    ) async {
      var exceededCount = 0;
      final controller = TextEditingController();
      await tester.pumpWidget(
        _wrap(
          KnittdaInput(
            controller: controller,
            maxLength: 100,
            onMaxLengthExceeded: () => exceededCount++,
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), '실/바늘 정보 예시 텍스트');
      await tester.pump();

      expect(exceededCount, 0);
    });

    testWidgets(
      '서로게이트 페어(코드 유닛 2개)로 이뤄진 글자는 grapheme 기준으로 세어 '
      '한도 이내면 onMaxLengthExceeded가 호출되지 않는다',
      (tester) async {
        var exceededCount = 0;
        final controller = TextEditingController();
        // '😀'는 grapheme 1개지만 UTF-16 코드 유닛은 2개다.
        final fiveEmoji = '😀' * 5;

        await tester.pumpWidget(
          _wrap(
            KnittdaInput(
              controller: controller,
              maxLength: 5,
              onMaxLengthExceeded: () => exceededCount++,
            ),
          ),
        );

        await tester.enterText(find.byType(TextFormField), fiveEmoji);
        await tester.pump();

        expect(exceededCount, 0);
      },
    );
  });
}
