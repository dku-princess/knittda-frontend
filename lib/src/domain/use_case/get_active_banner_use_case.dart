import 'package:knittda/src/data/data_sources/banner_local_storage.dart';
import 'package:knittda/src/domain/model/in_app_banner.dart';
import 'package:knittda/src/domain/repository/in_app_banner_repository.dart';

class GetActiveBannerUseCase {
  final InAppBannerRepository _repository;
  final BannerLocalStorage _localStorage;
  final String _currentAppVersion;

  GetActiveBannerUseCase({
    required InAppBannerRepository repository,
    required BannerLocalStorage localStorage,
    required String currentAppVersion,
  }) : _repository = repository,
       _localStorage = localStorage,
       _currentAppVersion = currentAppVersion;

  Future<List<InAppBanner>> call() async {
    final banners = await _repository.getBottomBanners();
    final now = DateTime.now();
    final result = <InAppBanner>[];

    for (final banner in banners) {
      //ActionData 유효성 검증
      if (!_isActionDataValid(banner)) continue;
      // 노출 기간 조건
      if (!_isWithinDateRange(banner, now)) continue;
      // audience 조건
      if (!_isAudienceMatched(banner, _currentAppVersion)) continue;
      // show_once_per_day + Local Storage
      if (await _localStorage.isDismissedForToday(banner.id)) continue;

      result.add(banner);
    }
    // priority 오름차순, 동일하면 id 오름차순
    result.sort((a, b) {
      final cmp = a.priority.compareTo(b.priority);
      return cmp != 0 ? cmp : a.id.compareTo(b.id);
    });

    return result;
  }

  //ActionData 유효성 검증
  bool _isActionDataValid(InAppBanner banner) {
    switch (banner.actionType) {
      case 'none':
        return true;

      case 'internal_route':
        final hasTarget =
            banner.targetType != null &&
            banner.targetType!.isNotEmpty &&
            banner.targetId != null;
        final hasRoute =
            banner.targetRoute != null && banner.targetRoute!.isNotEmpty;
        // 둘 중 하나라도 있으면 OK
        return hasTarget || hasRoute;

      case 'external_url':
        return banner.externalUrl != null && banner.externalUrl!.isNotEmpty;

      default:
        return false;
    }
  }

  // 노출 기간 조건
  bool _isWithinDateRange(InAppBanner banner, DateTime now) {
    if (banner.startAt != null && now.isBefore(banner.startAt!)) return false;
    if (banner.endAt != null && now.isAfter(banner.endAt!)) return false;
    return true;
  }

  // audience 조건
  bool _isAudienceMatched(InAppBanner banner, String currentAppVersion) {
    if (banner.audienceType == 'all') return true;

    if (banner.audienceType == 'specific_version') {
      final hasMin =
          banner.minAppVersion != null && banner.minAppVersion!.isNotEmpty;
      final hasMax =
          banner.maxAppVersion != null && banner.maxAppVersion!.isNotEmpty;

      // 범위가 하나도 없으면 잘못된 데이터 → 미노출
      if (!hasMin && !hasMax) return false;

      if (hasMin) {
        final cmp = _compareVersion(currentAppVersion, banner.minAppVersion!);
        if (cmp == null || cmp < 0) return false;
      }
      if (hasMax) {
        final cmp = _compareVersion(currentAppVersion, banner.maxAppVersion!);
        if (cmp == null || cmp > 0) return false;
      }
      return true;
    }

    // 알 수 없는 audienceType → 미노출
    return false;
  }

  // semver 방식으로 비교
  int? _compareVersion(String a, String b) {
    final partsA = a.trim().split('.');
    final partsB = b.trim().split('.');

    for (var i = 0; i < 3; i++) {
      final x = int.tryParse(i < partsA.length ? partsA[i] : '0');
      final y = int.tryParse(i < partsB.length ? partsB[i] : '0');

      // "2.beta.0" 같은 값이 오면 비교 불가 → null
      if (x == null || y == null) return null;
      if (x != y) return x - y;
    }
    return 0;
  }
}
