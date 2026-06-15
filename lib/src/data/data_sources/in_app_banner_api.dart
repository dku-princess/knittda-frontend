import 'package:dio/dio.dart';
import 'package:knittda/src/domain/model/in_app_banner.dart';
import 'package:knittda/src/performance/banner_load_tracker.dart';

class InAppBannerApi {
  final Dio _dio;
  final String _directusStatus;

  InAppBannerApi(this._dio, {required String directusStatus})
    : _directusStatus = directusStatus;

  Map<String, dynamic> get _statusFilter =>
      _directusStatus.isEmpty ? const {} : {'filter[status][_in]': _directusStatus};

  Future<List<InAppBanner>> fetchBottomBanners() async {
    final tracker = BannerLoadTracker.instance;
    if (tracker.isSessionActive) tracker.markT2(); // T2: HTTP 전송 직전
    final response = await _dio.get(
      '/items/in_app_banner',
      queryParameters: {
        ..._statusFilter,
        'filter[is_active][_eq]': true,
        'filter[placement][_eq]': 'bottom',
        'filter[priority][_nnull]': true,
        'sort': 'priority',
      },
    );
    if (tracker.isSessionActive) tracker.markT3(); // T3: 응답 수신 완료

    final List<dynamic> data = response.data['data'];

    return data.map((e) => InAppBanner.fromJson(e)).toList();
  }

  String getAssetUrl(String assetId) {
    return '${_dio.options.baseUrl}/assets/$assetId?width=750&format=webp&quality=85';
  }
}
