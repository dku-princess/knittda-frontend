import 'package:knittda/src/domain/model/announcement.dart';
import 'package:knittda/src/domain/repository/announcement_repository.dart';

class GetAnnouncementUseCase {
  final AnnouncementRepository _repository;

  GetAnnouncementUseCase(this._repository);

  Future<List<Announcement>> call() async {
    final list = await _repository.getAnnouncements();

    list.sort((a, b) {
      final pinCompare = (b.isPinned == true ? 1 : 0)
          .compareTo(a.isPinned == true ? 1 : 0);
      if (pinCompare != 0) return pinCompare;

      return b.publishedAt.compareTo(a.publishedAt);
    });

    return list;
  }
}