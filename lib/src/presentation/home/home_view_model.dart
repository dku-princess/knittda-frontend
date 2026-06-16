import 'package:flutter/material.dart';
import 'package:knittda/src/domain/repository/in_app_banner_repository.dart';
import 'package:knittda/src/domain/use_case/dismiss_banner_use_case.dart';
import 'package:knittda/src/domain/use_case/get_active_banner_use_case.dart';
import 'package:knittda/src/domain/util/banner_dismiss_type.dart';
import 'package:knittda/src/performance/banner_load_tracker.dart';
import 'package:knittda/src/presentation/home/home_state.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class HomeViewModel extends ChangeNotifier {
  final InAppBannerRepository _repository;
  final GetActiveBannerUseCase _getActiveBannerUseCase;
  final DismissBannerUseCase _dismissBannerUseCase;

  HomeState _state = HomeState(activeBanners: []);

  HomeState get state => _state;

  HomeViewModel({
    required InAppBannerRepository inAppBannerRepository,
    required GetActiveBannerUseCase getActiveBannerUseCase,
    required DismissBannerUseCase dismissBannerUseCase,
  }) : _repository = inAppBannerRepository,
       _getActiveBannerUseCase = getActiveBannerUseCase,
       _dismissBannerUseCase = dismissBannerUseCase;

  // 배너 목록 불러오기
  // 예시) [A,B,C] 로 들어오면 A -> 닫기 -> B -> 닫기 -> C 순서대로 보여주기
  Future<void> loadBanners() async {
    BannerLoadTracker.instance.markT1(); // T1: 로딩 시작
    try {
      final activeBanners = await _getActiveBannerUseCase.call();
      _state = state.copyWith(activeBanners: activeBanners);
      if (activeBanners.isEmpty) {
        BannerLoadTracker.instance.abortSession(); // 노출할 배너 없음
      }
    } catch (e, st) {
      Sentry.captureException(e, stackTrace: st);
      BannerLoadTracker.instance.abortSession(); // API 오류
      _state = state.copyWith(activeBanners: []);
    }
    notifyListeners();
  }

  // 배너 닫기
  Future<void> dismissBanner(BannerDismissType dismissType) async {
    final current = _state.currentBanner;
    if (current == null) return;

    // UI 먼저 업데이트
    _state = _state.copyWith(
      activeBanners: _state.activeBanners
          .where((b) => b.id != current.id)
          .toList(),
    );
    notifyListeners();

    // 저장은 비동기로 뒤에서 처리
    try {
      await _dismissBannerUseCase.call(
        banner: current,
        dismissType: dismissType,
      );
    } catch (e, st) {
      Sentry.captureException(e, stackTrace: st);
    }
  }

  String getAssetUrl(String assetId) => _repository.getAssetUrl(assetId);
}
