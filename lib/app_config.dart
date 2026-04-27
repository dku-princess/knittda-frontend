class AppConfig {
  static const String kakaoNativeAppKey = String.fromEnvironment('KAKAO_NATIVE_APP_KEY');
  static const String sentryDsn = String.fromEnvironment('SENTRY_DSN');
  static const String apiBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const String directusBaseUrl = String.fromEnvironment('DIRECTUS_BASE_URL');
  static const String articleStatus = String.fromEnvironment('ARTICLE_STATUS');
  static const String sentryEnvironment = String.fromEnvironment(
    'SENTRY_ENVIRONMENT',
    defaultValue: 'development',
  );
  static const String sentryRelease = String.fromEnvironment('SENTRY_RELEASE');
  static const String appChannel = String.fromEnvironment(
    'APP_CHANNEL',
    defaultValue: 'beta',
  );
}