import 'package:flutter/material.dart';
import 'package:knittda/src/domain/use_case/get_announcement_use_case.dart';
import 'package:knittda/src/presentation/announcement/announcement_state.dart';

class AnnouncementViewModel extends ChangeNotifier {
  final GetAnnouncementUseCase _getAnnouncementUseCase;
  static const int _pageSize = 25;

  AnnouncementState _state = AnnouncementState();

  AnnouncementState get state => _state;

  AnnouncementViewModel(this._getAnnouncementUseCase) {
    loadAnnouncement();
  }

  Future<void> loadAnnouncement() async {
    _state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final result = await _getAnnouncementUseCase.call(
        limit: _pageSize,
        offset: 0,
      );
      _state = state.copyWith(
        announcements: result.announcements,
        totalCount: result.totalCount,
      );
    } catch (e) {
      final error = e.toString().replaceFirst('Exception: ', '');
      _state = state.copyWith(errorMessage: error);
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

    _state = state.copyWith(isLoadingMore: true);
    notifyListeners();

    try {
      final result = await _getAnnouncementUseCase.call(
        limit: _pageSize,
        offset: state.announcements.length,
      );
      final updated = [...state.announcements, ...result.announcements];
      _state = state.copyWith(
        announcements: updated,
        totalCount: result.totalCount,
      );
    } catch (e) {
      debugPrint('추가 로딩 실패: $e');
    }

    _state = state.copyWith(isLoadingMore: false);
    notifyListeners();
  }
}
