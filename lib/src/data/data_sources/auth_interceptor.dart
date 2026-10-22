import 'package:dio/dio.dart';
import 'package:knittda/src/data/data_sources/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage _storage;
  final Map<String, String> _staticHeaders;

  AuthInterceptor(
    this._storage, {
    Map<String, String> staticHeaders = const {},
  }) : _staticHeaders = staticHeaders;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['X-Request-Id'] = _buildRequestId();
    _staticHeaders.forEach((k, v) => options.headers[k] = v);

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      try {
        final token = await _storage.readToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      } catch (_) {
        // 토큰 읽기 실패 시 인증 없이 진행 (서버에서 401 처리)
      }
    }

    handler.next(options);
  }

  String _buildRequestId() {
    final now = DateTime.now().microsecondsSinceEpoch;
    final randomPart = now.remainder(1000000).toRadixString(16).padLeft(5, '0');
    return 'flutter-$now-$randomPart';
  }
}
