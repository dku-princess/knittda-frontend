import 'dart:io';

import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String? localImageUrl;
  final String? networkImageUrl;
  final double? width;
  final double? height;
  final bool showIcon;

  const ImageBox({
    this.localImageUrl,
    this.networkImageUrl,
    this.width = 60,
    this.height = 60,
    this.showIcon = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (localImageUrl != null && localImageUrl!.isNotEmpty) {
      return _buildImage(FileImage(File(localImageUrl!)));
    } else if (networkImageUrl != null && networkImageUrl!.isNotEmpty) {
      return _buildImage(NetworkImage(networkImageUrl!));
    } else {
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
