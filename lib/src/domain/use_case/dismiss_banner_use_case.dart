import 'package:knittda/src/data/data_sources/banner_local_storage.dart';
import 'package:knittda/src/domain/model/in_app_banner.dart';
import 'package:knittda/src/domain/util/banner_dismiss_type.dart';

class DismissBannerUseCase {
  final BannerLocalStorage _localStorage;

  DismissBannerUseCase(this._localStorage);

  Future<void> call({
    required InAppBanner banner,
    required BannerDismissType dismissType,
  }) async {
    switch (dismissType) {
      // 배너 바깥 영역 탭
      // localStorage 저장 안 함 → 앱 재실행 시 재노출
      case BannerDismissType.outsideTap:
        return;

      // 닫기 버튼
      // showOncePerDay=true일 때만 저장
      case BannerDismissType.close:
        if (banner.showOncePerDay) {
          await _localStorage.dismissForToday(banner.id);
        }

      // "하루 동안 보지 않기" 버튼
      case BannerDismissType.dismissForToday:
        await _localStorage.dismissForToday(banner.id);
    }
  }
}
