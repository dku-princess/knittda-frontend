import 'package:knittda/src/domain/model/in_app_banner.dart';

abstract class InAppBannerRepository {
  Future<List<InAppBanner>> getBottomBanners();

  String getAssetUrl(String assetId);
}