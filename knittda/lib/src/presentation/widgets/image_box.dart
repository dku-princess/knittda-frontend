import 'dart:io';

import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String? localImageUrl;
  final String? networkImageUrl;
  final double? width;
  final double? height;
  final bool showIcon;
  final VoidCallback? onRemove;

  const ImageBox({
    this.localImageUrl,
    this.networkImageUrl,
    this.width = 60,
    this.height = 60,
    this.showIcon = false,
    this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hasLocal = localImageUrl != null && localImageUrl!.isNotEmpty;
    final hasNetwork = networkImageUrl != null && networkImageUrl!.isNotEmpty;

    if (hasLocal || hasNetwork) {
      final image = hasLocal
          ? FileImage(File(localImageUrl!)) as ImageProvider
          : NetworkImage(networkImageUrl!);

      return Stack(
        children: [
          _buildImage(image),
          if (onRemove != null)
            Positioned(
              top: 2,
              right: 2,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.close, size: 14, color: Colors.white),
                ),
              ),
            ),
        ],
      );
    }

    // 비어있는 경우 (아이콘 표시 여부)
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

  Widget _buildImage(ImageProvider image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image(
        image: image,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
