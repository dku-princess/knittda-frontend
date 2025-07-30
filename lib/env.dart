// 환경 변수 및 설정 상수 (CI에서 자동 생성됨)
class Env {
  // Kakao SDK 설정
  static const String kakaoNativeAppKey = 'test_kakao_key';
  
  // Sentry 설정
  static const String SentryFlutterDns = 'https://test@sentry.io/test';
  
  // API 설정
  static const String apiBaseUrl = 'https://api.example.com';
  
  // 기타 환경 설정
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');
  static const bool isDebug = !isProduction;
}
