import 'package:flutter/material.dart';
import 'package:knittda/src/domain/model/in_app_banner.dart';
import 'package:knittda/src/domain/util/banner_dismiss_type.dart';

class BottomBannerOverlay extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.5),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onDismiss(BannerDismissType.outsideTap),
                  behavior: HitTestBehavior.opaque,
                ),
              ),
              // 배너 이미지
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: banner.actionType == 'none' ? null : onTapBanner,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: 3 / 2,
                      child: imageUrl != null
                          ? Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(color: Colors.grey.shade200),
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
                      onPressed: () => onDismiss(BannerDismissType.dismissForToday),
                      child: const Text(
                        '하루 동안 보지 않기',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () => onDismiss(BannerDismissType.close),
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
