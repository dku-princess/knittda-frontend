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
    if(options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await _storage.readToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }
}
