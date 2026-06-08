import 'package:dio/dio.dart';
import 'package:knittda/src/domain/model/in_app_banner.dart';

class InAppBannerApi {
  final Dio _dio;
  final String _directusStatus;

  InAppBannerApi(this._dio, {required String directusStatus})
    : _directusStatus = directusStatus;

  Future<List<InAppBanner>> fetchBottomBanners() async {
    final response = await _dio.get(
      '/items/in_app_banner',
      queryParameters: {
        if (_directusStatus.isNotEmpty) 'filter[status][_in]': _directusStatus,
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
