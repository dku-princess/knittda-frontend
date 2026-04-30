import 'package:dio/dio.dart';
import 'package:knittda/src/data/data_sources/in_app_banner_api.dart';
import 'package:knittda/src/domain/model/in_app_banner.dart';
import 'package:knittda/src/domain/repository/in_app_banner_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class InAppBannerRepositoryImpl implements InAppBannerRepository {
  final InAppBannerApi _api;

  InAppBannerRepositoryImpl(this._api);

  @override
  Future<List<InAppBanner>> getBottomBanners() async {
    try {
      return await _api.fetchBottomBanners();
    } on DioException catch (e, st) {
      Sentry.captureException(e, stackTrace: st);
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          throw Exception('서버 응답 시간이 초과되었습니다.');
        case DioExceptionType.connectionError:
          throw Exception('네트워크 연결을 확인해주세요.');
        case DioExceptionType.badResponse:
          throw Exception('서버 오류가 발생했습니다. (${e.response?.statusCode})');
        default:
          throw Exception('네트워크 오류가 발생했습니다.');
      }
    } catch (e, st) {
      Sentry.captureException(e, stackTrace: st);
      throw Exception('알 수 없는 오류가 발생했습니다: $e');
    }
  }

  @override
  String getAssetUrl(String assetId) => _api.getAssetUrl(assetId);
}
