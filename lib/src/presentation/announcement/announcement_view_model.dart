import 'package:flutter/material.dart';
import 'package:knittda/src/domain/use_case/get_announcement_use_case.dart';
import 'package:knittda/src/presentation/announcement/announcement_state.dart';

class AnnouncementViewModel extends ChangeNotifier {
  final GetAnnouncementUseCase _getAnnouncementUseCase;

  AnnouncementState _state = AnnouncementState(
    announcements: [],
    isLoading: false,
  );

  AnnouncementState get state => _state;

  AnnouncementViewModel(this._getAnnouncementUseCase) {
    loadAnnouncement();
  }

  Future<void> loadAnnouncement() async {
    _state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final announcements = await _getAnnouncementUseCase.call();
      _state = state.copyWith(announcements: announcements);
    } catch (e) {
      final error = e.toString().replaceFirst('Exception: ', '');
      _state = state.copyWith(errorMessage: error);
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }
}
