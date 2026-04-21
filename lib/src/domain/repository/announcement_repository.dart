import 'package:knittda/src/domain/model/announcement.dart';

abstract class AnnouncementRepository {
  Future<({List<Announcement> announcements, int totalCount})>
  getAnnouncements({int limit = 25, int offset = 0});

  String getAssetUrl(String assetId);
}
