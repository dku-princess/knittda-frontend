import 'package:dio/dio.dart';
import 'package:knittda/src/domain/model/announcement.dart';

class AnnouncementApi {
  final Dio _dio;
  final String _directusStatus;

  AnnouncementApi(this._dio, {required String directusStatus})
    : _directusStatus = directusStatus;

  Map<String, dynamic> get _statusFilter =>
      _directusStatus.isEmpty ? const {} : {'filter[status][_in]': _directusStatus};

  Future<({List<Announcement> announcements, int totalCount})>
  fetchAnnouncements({int limit = 25, int offset = 0}) async {
    final response = await _dio.get(
      '/items/announcements',
      queryParameters: {
        ..._statusFilter,
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

  Future<Announcement?> fetchAnnouncement(String slugOrId) async {
    final isId = int.tryParse(slugOrId) != null;
    final filterKey = isId ? 'filter[id][_eq]' : 'filter[slug][_eq]';

    final response = await _dio.get(
      '/items/announcements',
      queryParameters: {
        ..._statusFilter,
        filterKey: slugOrId,
        'fields': 'id,status,is_pinned,title,slug,description,category,published_at,body,tracking_label',
      },
    );

    final list = response.data['data'];

    if (list is! List || list.isEmpty) return null;

    return Announcement.fromJson(list.first);
  }

  String getAssetUrl(String assetId) {
    return '${_dio.options.baseUrl}/assets/$assetId';
  }
}
