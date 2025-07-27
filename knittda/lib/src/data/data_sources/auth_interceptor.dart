import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:knittda/src/core/storage/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage _storage;

  AuthInterceptor(this._storage);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final jwt = await _storage.read();
      if (jwt != null) {
        options.headers['Authorization'] = 'Bearer $jwt';
        // if (kDebugMode) {
        //   debugPrint('[AuthInterceptor] JWT attached: $jwt');
        // }
      } else {
        // if (kDebugMode) {
        //   debugPrint('[AuthInterceptor] No JWT found.');
        // }
      }
    } catch (e) {
      //debugPrint('[AuthInterceptor] Error reading token: $e');
    }

    handler.next(options);
  }
}