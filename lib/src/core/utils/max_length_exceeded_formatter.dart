import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 최대 글자 수를 넘겨 입력을 시도하면 [onExceeded]를 호출한다.
///
/// 실제 길이 제한(truncation)은 [TextField.maxLength]가 담당하므로,
/// 여기서는 넘침 여부만 감지해 알림을 띄우는 역할만 한다.
class MaxLengthExceededFormatter extends TextInputFormatter {
  MaxLengthExceededFormatter(this.maxLength, this.onExceeded);

  final int maxLength;
  final VoidCallback? onExceeded;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // TextField(maxLength: ...)가 자동으로 붙이는 LengthLimitingTextInputFormatter는
    // 사용자가 지정한 inputFormatters 뒤에 실행된다(Flutter 내부 동작, 공개 계약은 아님).
    // 그래서 여기서는 아직 잘리지 않은 newValue를 보고 초과 여부를 판단할 수 있다.
    // 이 순서가 바뀌면 onExceeded가 조용히 호출되지 않게 되는데,
    // knittda_input_test.dart의 "초과 시 콜백이 호출된다" 테스트가 이를 감지한다.
    //
    // 길이 비교는 String.length(UTF-16 코드 유닛)가 아니라 characters.length
    // (grapheme 클러스터)로 해야 한다. LengthLimitingTextInputFormatter도 같은
    // 기준으로 자르므로, 기준이 다르면 이모지 등에서 실제로는 한도 이내인데도
    // 초과로 오판해 스낵바가 잘못 뜰 수 있다.
    if (newValue.text.characters.length > maxLength) {
      onExceeded?.call();
    }
    return newValue;
  }
}
