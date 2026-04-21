import 'package:dio/dio.dart';
import 'package:knittda/src/data/data_sources/announcement_api.dart';
import 'package:knittda/src/domain/model/announcement.dart';
import 'package:knittda/src/domain/repository/announcement_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final AnnouncementApi _api;

  AnnouncementRepositoryImpl(this._api);

  @override
  Future<({List<Announcement> announcements, int totalCount})>
  getAnnouncements({int limit = 25, int offset = 0}) async {
    try {
      return await _api.fetchAnnouncements(limit: limit, offset: offset);
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
  Future<Announcement?> fetchAnnouncement(String slugOrId) async {
    try {
      return await _api.fetchAnnouncement(slugOrId);
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
