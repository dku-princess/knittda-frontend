import 'package:flutter/material.dart';
import 'package:knittda/src/core/theme/theme.dart';

/// Knittda 공통 네트워크 이미지.
///
/// 상태를 **두 가지**로만 다룬다.
/// - **placeholder**: 빈/누락 URL과 로드 실패를 **하나로 통합**한 표현
///   (배경 [backgroundColor] + `grey400` [placeholderIcon] · [iconSize]).
/// - **loading**: [showLoading]일 때만 배경 위 스피너로 별도 처리.
///
/// [borderRadius] 지정 시 `ClipRRect`로 감싼다.
class KnittdaNetworkImage extends StatelessWidget {
  const KnittdaNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.backgroundColor = AppColors.grey200,
    this.placeholderIcon = Icons.image_outlined,
    this.iconSize = AppIconSize.xl,
    this.showLoading = true,
  });

  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color backgroundColor;

  /// 빈 URL·로드 실패 시 공통으로 표시할 placeholder 아이콘.
  final IconData placeholderIcon;
  final double iconSize;
  final bool showLoading;

  Widget get _placeholder => Container(
        width: width,
        height: height,
        color: backgroundColor,
        alignment: Alignment.center,
        child: Icon(placeholderIcon, color: AppColors.grey400, size: iconSize),
      );

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (url == null || url!.isEmpty) {
      child = _placeholder;
    } else {
      child = Image.network(
        url!,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: showLoading
            ? (context, imageChild, progress) {
                if (progress == null) return imageChild;
                return Container(
                  width: width,
                  height: height,
                  color: backgroundColor,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                );
              }
            : null,
        errorBuilder: (context, error, stackTrace) => _placeholder,
      );
    }
    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: child);
    }
    return child;
  }
}
