import 'package:flutter/material.dart';
import 'package:knittda/src/domain/model/in_app_banner.dart';
import 'package:knittda/src/domain/util/banner_dismiss_type.dart';
import 'package:knittda/src/performance/banner_load_tracker.dart';

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

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.5),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: widget.banner.actionType == 'none' ? null : widget.onTapBanner,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
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
                                return Container(color: Colors.grey.shade200);
                              },
                            )
                          : Container(color: Colors.grey.shade200),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // 하단 버튼
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => widget.onDismiss(BannerDismissType.dismissForToday),
                      child: const Text(
                        '하루 동안 보지 않기',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () => widget.onDismiss(BannerDismissType.close),
                      child: const Text(
                        '닫기',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
