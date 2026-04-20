import 'package:knittda/src/domain/model/announcement.dart';

abstract class AnnouncementRepository {
  Future<List<Announcement>> getAnnouncements();

  String getAssetUrl(String assetId);
}
