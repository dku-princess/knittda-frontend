import 'dart:io';
import 'package:flutter/material.dart';

// class WorkImageBox extends StatefulWidget {
//   final String? networkUrl;   // http/https
//   final String? localPath;    // 기기 파일 경로
//   final String? assetPath;    // assets/images/...
//   final double width;
//   final double height;
//
//   const WorkImageBox({
//     super.key,
//     this.networkUrl,
//     this.localPath,
//     this.assetPath,
//     this.width = 60,
//     this.height = 60,
//   });
//
//   @override
//   State<WorkImageBox> createState() => _WorkImageBoxState();
// }
//
// class _WorkImageBoxState extends State<WorkImageBox> {
//   late final Stopwatch _watch;
//   ImageProvider? _provider;
//   ImageStream? _stream;
//   late final ImageStreamListener _listener;
//
//   @override
//   void initState() {
//     super.initState();
//     _provider = _pickProvider();
//     if (_provider == null) return;
//
//     _watch = Stopwatch()..start();
//
//     _stream = _provider!.resolve(const ImageConfiguration());
//     _listener = ImageStreamListener(
//           (info, _) {
//         _watch.stop();
//         debugPrint('⏱️ [${_sourceKey()}] loaded in ${_watch.elapsedMilliseconds} ms');
//       },
//       onError: (error, stack) {
//         _watch.stop();
//         debugPrint('❌ [${_sourceKey()}] load failed: $error');
//       },
//     );
//
//     _stream!.addListener(_listener);
//   }
//
//   @override
//   void dispose() {
//     // 이미지가 아직 안 끝났거나, 애니메이션이라면 여기서 확실히 해제
//     if (_stream != null) {
//       _stream!.removeListener(_listener);
//     }
//     super.dispose();
//   }
//   // ──────────────────────────────────────────────────────────── UI ─────────────
//
//   @override
//   Widget build(BuildContext context) {
//     if (_provider == null) {
//       return _emptyBox();
//     }
//
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(6),
//       child: Image(
//         image: _provider!,
//         width: widget.width,
//         height: widget.height,
//         fit: BoxFit.cover,
//         errorBuilder: (_, __, ___) => _errorBox(),
//       ),
//     );
//   }
//
//   // ────────────────────────────────────────────────────── Helpers ──────────────
//
//   ImageProvider? _pickProvider() {
//     if (widget.assetPath?.isNotEmpty ?? false) {
//       return AssetImage(widget.assetPath!);
//     } else if (widget.localPath?.isNotEmpty ?? false) {
//       return FileImage(File(widget.localPath!));
//     } else if (widget.networkUrl?.isNotEmpty ?? false) {
//       return NetworkImage(widget.networkUrl!);
//     }
//     return null;
//   }
//
//   String _sourceKey() =>
//       widget.networkUrl ?? widget.localPath ?? widget.assetPath ?? 'unknown';
//
//   Widget _emptyBox() => Container(
//     width: widget.width,
//     height: widget.height,
//     decoration: BoxDecoration(
//       color: Colors.grey[300],
//       borderRadius: BorderRadius.circular(6),
//     ),
//   );
//
//   Widget _errorBox() => Container(
//     width: widget.width,
//     height: widget.height,
//     color: Colors.grey[300],
//     alignment: Alignment.center,
//     child: const Icon(Icons.broken_image, color: Colors.white),
//   );
// }
