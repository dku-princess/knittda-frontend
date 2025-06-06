import 'dart:io';

import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String? localImageUrl;
  final String? networkImageUrl;
  final String? assetImagePath;
  final double? width;
  final double? height;
  final bool showIcon;
  final VoidCallback? onRemove;

  const ImageBox({
    this.localImageUrl,
    this.networkImageUrl,
    this.assetImagePath,
    this.width = 60,
    this.height = 60,
    this.showIcon = false,
    this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final image = _resolveImage();

    if (image != null) {
      return Stack(
        children: [
          _buildImage(image),
          if (onRemove != null) _buildRemoveButton(),
        ],
      );
    }

    return _buildEmptyBox();
  }

  /// 이미지 소스를 결정하는 메서드
  ImageProvider? _resolveImage() {
    if (assetImagePath?.isNotEmpty ?? false) {
      return AssetImage(assetImagePath!);
    } else if (localImageUrl?.isNotEmpty ?? false) {
      return FileImage(File(localImageUrl!));
    } else if (networkImageUrl?.isNotEmpty ?? false) {
      return NetworkImage(networkImageUrl!);
    }
    return null;
  }

  /// 이미지 출력 위젯
  Widget _buildImage(ImageProvider image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image(
        image: image,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: const Icon(Icons.broken_image, color: Colors.white),
          );
        },
      ),
    );
  }

  /// 삭제 아이콘 버튼
  Widget _buildRemoveButton() {
    return Positioned(
      top: 2,
      right: 2,
      child: GestureDetector(
        onTap: onRemove,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(4),
          child: const Icon(Icons.close, size: 14, color: Colors.white),
        ),
      ),
    );
  }

  /// 이미지가 없을 때 박스 UI
  Widget _buildEmptyBox() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(6),
      ),
      child: showIcon
          ? const Icon(Icons.add, color: Colors.white, size: 50)
          : null,
    );
  }
}
