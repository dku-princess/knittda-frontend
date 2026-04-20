import 'package:dio/dio.dart';
import 'package:knittda/src/domain/model/announcement.dart';

class AnnouncementApi {
  final Dio _dio;
  final String _directusStatus;

  AnnouncementApi(this._dio, {required String directusStatus})
    : _directusStatus = directusStatus;

  Future<List<Announcement>> fetchAnnouncements() async {
    final response = await _dio.get(
      '/items/announcements',
      queryParameters: {
        'filter[status][_in]': _directusStatus,
        'sort': '-is_pinned,-published_at',
      },
    );

    final List<dynamic> data = response.data['data'];

    return data.map((e) => Announcement.fromJson(e)).toList();
  }

  String getAssetUrl(String assetId) {
    return '${_dio.options.baseUrl}/assets/$assetId';
  }
}
