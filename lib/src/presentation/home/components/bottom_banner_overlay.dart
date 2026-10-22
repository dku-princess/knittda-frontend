import 'package:flutter/material.dart';
import 'package:knittda/src/domain/model/in_app_banner.dart';
import 'package:knittda/src/domain/util/banner_dismiss_type.dart';
import 'package:knittda/src/performance/banner_load_tracker.dart';
import 'package:knittda/src/core/theme/theme.dart';

class BottomBannerOverlay extends StatefulWidget {
  final InAppBanner banner;
  final String? imageUrl;
  final ValueChanged<BannerDismissType> onDismiss;
  final VoidCallback onTapBanner;

  const BottomBannerOverlay({
    super.key,
    required this.banner,
    required this.imageUrl,
    required this.onDismiss,
    required this.onTapBanner,
  });

  @override
  State<BottomBannerOverlay> createState() => _BottomBannerOverlayState();
}

class _BottomBannerOverlayState extends State<BottomBannerOverlay> {
  bool _imageMeasured = false;

  // 이미지가 측정되기 전에 위젯이 해제되면 image_download span과 트랜잭션을
  // 명시적으로 종료하여 BannerLoadTracker 세션이 영구 잠금 상태에 빠지지 않도록 한다.
  @override
  void dispose() {
    if (!_imageMeasured && BannerLoadTracker.instance.isSessionActive) {
      BannerLoadTracker.instance.abortSession();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: AppColors.black.withValues(alpha: 0.5),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => widget.onDismiss(BannerDismissType.outsideTap),
                  behavior: HitTestBehavior.opaque,
                ),
              ),
              // 배너 이미지
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
                child: GestureDetector(
                  onTap: widget.banner.actionType == 'none' ? null : widget.onTapBanner,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    child: AspectRatio(
                      aspectRatio: 3 / 2,
                      child: widget.imageUrl != null
                          ? Image.network(
                              widget.imageUrl!,
                              fit: BoxFit.cover,
                              // T5: 이미지 첫 프레임 디코딩 완료
                              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                if (frame != null && !_imageMeasured) {
                                  _imageMeasured = true;
                                  BannerLoadTracker.instance.markT5();
                                }
                                return child;
                              },
                              errorBuilder: (context, error, stackTrace) {
                                if (!_imageMeasured) {
                                  _imageMeasured = true;
                                  BannerLoadTracker.instance.markT5ImageError();
                                }
                                return Container(color: AppColors.grey200);
                              },
                            )
                          : Container(color: AppColors.grey200),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.space12),
              // 하단 버튼
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => widget.onDismiss(BannerDismissType.dismissForToday),
                      child: const Text(
                        '하루 동안 보지 않기',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () => widget.onDismiss(BannerDismissType.close),
                      child: const Text(
                        '닫기',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.space32),
            ],
          ),
        ),
      ),
    );
  }
}
