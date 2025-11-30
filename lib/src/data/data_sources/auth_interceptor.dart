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
    final token = await _storage.readToken();
    final hasToken = token?.isNotEmpty == true;

    if (hasToken) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
