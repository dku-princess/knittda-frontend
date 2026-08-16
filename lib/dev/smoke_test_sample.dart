// 임시: Claude 자동 리뷰 동작 확인용 파일 (테스트 후 삭제 예정)

int divide(int a, int b) {
  // 0으로 나누는 경우를 검사하지 않음 (리뷰가 잡는지 확인용)
  return a ~/ b;
}

String greet(String? name) {
  // null 안정성 미흡 (리뷰가 잡는지 확인용)
  return "Hello, " + name!.toUpperCase();
}
