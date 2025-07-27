import 'package:dio/dio.dart';
import 'package:knittda/src/core/storage/token_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage _storage;

  AuthInterceptor(this._storage);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final jwt = await _storage.read();
      final hasToken = jwt?.isNotEmpty == true;

      if (hasToken) {
        options.headers['Authorization'] = 'Bearer $jwt';
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
    }

    handler.next(options);
  }
}