import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/analytics_service.dart';
import 'package:knittda/src/domain/repository/announcement_repository.dart';
import 'package:knittda/src/presentation/announcement_detail/announcement_detail_state.dart';

class AnnouncementDetailViewModel extends ChangeNotifier {
  final AnnouncementRepository _repository;

  AnnouncementDetailState _state = AnnouncementDetailState(
    announcement: null,
    isLoading: false,
  );

  AnnouncementDetailState get state => _state;

  AnnouncementDetailViewModel(this._repository, {required String slugOrId}) {
    loadAnnouncement(slugOrId);
  }

  Future<void> loadAnnouncement(String slugOrId) async {
    _state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final announcement = await _repository.getAnnouncement(slugOrId);
      _state = state.copyWith(announcement: announcement);
      if (announcement != null) {
        AnalyticsService.instance
            .logViewAnnouncement(announcement.id.toString());
      }
    } on Exception catch (e) {
      final error = e.toString().replaceFirst('Exception: ', '');
      _state = state.copyWith(errorMessage: error);
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  String getAssetUrl(String assetId) => _repository.getAssetUrl(assetId);
}
