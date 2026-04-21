import 'package:knittda/src/domain/model/announcement.dart';
import 'package:knittda/src/domain/repository/announcement_repository.dart';

class GetAnnouncementUseCase {
  final AnnouncementRepository _repository;

  GetAnnouncementUseCase(this._repository);

  Future<({List<Announcement> announcements, int totalCount})> call({
    int limit = 25,
    int offset = 0,
  }) async {
    return await _repository.getAnnouncements(limit: limit, offset: offset);
  }
}
