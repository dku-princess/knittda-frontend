import 'package:knittda/src/domain/model/announcement.dart';

abstract class AnnouncementRepository {
  Future<({List<Announcement> announcements, int totalCount})>
  getAnnouncements({int limit = 25, int offset = 0});

  Future<Announcement?> getAnnouncement(String slugOrId);

  String getAssetUrl(String assetId);
}
