import 'package:dio/dio.dart';
import 'package:knittda/src/domain/model/in_app_banner.dart';

class InAppBannerApi {
  final Dio _dio;
  final String _directusStatus;

  InAppBannerApi(this._dio, {required String directusStatus})
    : _directusStatus = directusStatus;

  // 빈 값이면 status 필터를 생략하여 모든 상태(draft/published/archived 등) 허용
  Map<String, dynamic> get _statusFilter =>
      _directusStatus.isEmpty ? const {} : {'filter[status][_in]': _directusStatus};

  Future<List<InAppBanner>> fetchBottomBanners() async {
    final response = await _dio.get(
      '/items/in_app_banner',
      queryParameters: {
        ..._statusFilter,
        'filter[is_active][_eq]': true,
        'filter[placement][_eq]': 'bottom',
        'sort': 'priority',
      },
    );

    final List<dynamic> data = response.data['data'];

    return data.map((e) => InAppBanner.fromJson(e)).toList();
  }

  String getAssetUrl(String assetId) {
    return '${_dio.options.baseUrl}/assets/$assetId';
  }
}
