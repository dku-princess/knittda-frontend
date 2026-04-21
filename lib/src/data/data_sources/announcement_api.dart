import 'package:dio/dio.dart';
import 'package:knittda/src/domain/model/announcement.dart';

class AnnouncementApi {
  final Dio _dio;
  final String _directusStatus;

  AnnouncementApi(this._dio, {required String directusStatus})
    : _directusStatus = directusStatus;

  Future<({List<Announcement> announcements, int totalCount})>
  fetchAnnouncements({int limit = 25, int offset = 0}) async {
    final response = await _dio.get(
      '/items/announcements',
      queryParameters: {
        'filter[status][_in]': _directusStatus,
        'sort': '-is_pinned,-published_at',
        'limit': limit,
        'offset': offset,
        'meta': 'filter_count',
      },
    );

    final List<dynamic> data = response.data['data'];

    final int totalCount = response.data['meta']['filter_count'] ?? 0;
    return (
      announcements: data.map((e) => Announcement.fromJson(e)).toList(),
      totalCount: totalCount,
    );
  }

  String getAssetUrl(String assetId) {
    return '${_dio.options.baseUrl}/assets/$assetId';
  }
}
