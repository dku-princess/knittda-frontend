import 'dart:io';

import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String? localImageUrl;
  final String? networkImageUrl;
  final double width;
  final double height;
  final VoidCallback onRemove;

  const ImageBox({
    this.localImageUrl,
    this.networkImageUrl,
    this.width = 60,
    this.height = 60,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ImageProvider image =
    (localImageUrl?.isNotEmpty ?? false)
        ? FileImage(File(localImageUrl!))
        : NetworkImage(networkImageUrl!);

    return Stack(
      children: [
        ClipRRect(
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
        ),
        Positioned(
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
        ),
      ],
    );
  }
}