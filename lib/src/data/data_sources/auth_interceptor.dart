import 'package:dio/dio.dart';
import 'package:knittda/src/data/data_sources/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage _storage;

  AuthInterceptor(this._storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['X-Request-Id'] = _buildRequestId();

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await _storage.readToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
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
