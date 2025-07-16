import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

final GlobalKey captureKey = GlobalKey();
const platform = MethodChannel('com.knittda/image_saver');

Future<Uint8List?> captureWidget(GlobalKey key) async {
  RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
  ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData?.buffer.asUint8List();
}

Future<void> saveImageToGallery(Uint8List bytes) async {
  try {
    await platform.invokeMethod('saveImage', {"bytes": bytes});
  } catch (e) {
    debugPrint('Error saving image: $e');
  }
}
