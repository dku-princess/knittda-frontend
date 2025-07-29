import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/presentation/view_models/report_view_model.dart';
import 'package:provider/provider.dart';

import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gal/gal.dart';
import 'dart:typed_data';

final List<Map<String, dynamic>> scoreRanges = [
  {"min": 0, "max": 0, "label": "바나나독", "image": "assets/image/stage/stage1.png"},
  {"min": 1, "max": 10, "label": "쏘쏘캣", "image": "assets/image/stage/stage2.png"},
  {"min": 11, "max": 20, "label": "우이이 아이이", "image": "assets/image/stage/stage3.png"},
  {"min": 21, "max": 30, "label": "퀸리틀크라이", "image": "assets/image/stage/stage4.png"},
  {"min": 31, "max": 40, "label": "핫가이", "image": "assets/image/stage/stage5.png"},
  {"min": 41, "max": 50, "label": "아하 소년", "image": "assets/image/stage/stage6.png"},
  {"min": 51, "max": 60, "label": "뜨뜨뜨 사후르", "image": "assets/image/stage/stage7.png"},
  {"min": 61, "max": 70, "label": "뜨랄랄레로 뜨랄랄라", "image": "assets/image/stage/stage8.png"},
  {"min": 71, "max": double.infinity, "label": "뜨피노사우르스", "image": "assets/image/stage/stage9.png"},
];

Map<String, String?> scoreToStage(double score) {
  final result = scoreRanges.firstWhere(
        (range) => score >= range["min"] && score <= range["max"],
    orElse: () => {
      "label": "범위를 벗어남",
      "image": null,
    },
  );

  return {
    "label": result["label"],
    "image": result["image"],
  };
}

class ReportUi extends StatefulWidget {
  const ReportUi({super.key});

  @override
  State<ReportUi> createState() => _ReportUiState();
}

class _ReportUiState extends State<ReportUi> {
  // Screenshot 컨트롤러
  final GlobalKey _captureKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportViewModel>().fetchReport();
    });
  }

  Future<Uint8List?> _capture() async {
    final ctx = _captureKey.currentContext;
    if (ctx == null) return null;  // 뷰가 아직 없을 때 대비

    // 첫 프레임 미도달 대비
    final boundary = ctx.findRenderObject() as RenderRepaintBoundary;
    if (boundary.debugNeedsPaint) {
      await Future.delayed(const Duration(milliseconds: 16));
      return _capture();
    }

    final image = await boundary.toImage(pixelRatio: 3.0);     // 해상도 ↑
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  // 저장 버튼 로직
  Future<void> _saveToGallery() async {
    try {
      Uint8List? bytes = await _capture();
      if (bytes == null) return;

      await Gal.putImageBytes(bytes, album: 'KnittingReport');

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('갤러리에 저장되었습니다!')),
      );
    } catch (e) {
      debugPrint('Save error: $e');
    }
  }

  // 공유 버튼 로직
  Future<void> _shareReport() async {
    try {
      final bytes = await _capture();
      if (bytes == null) return;

      final dir  = await getTemporaryDirectory();
      final file = await File(
        '${dir.path}/report_${DateTime.now().millisecondsSinceEpoch}.png',
      ).writeAsBytes(bytes);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: '이번 주 뜨개 리포트',
        ),
      );
    } catch (e) {
      debugPrint('Share error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final reportVM = context.watch<ReportViewModel>();
    final report = reportVM.report;
    final isLoading = reportVM.isLoading;
    final error = reportVM.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(child: Text('에러: $error'));
    }

    if (report == null) {
      return const Center(child: Text('데이터 없음'));
    }

    final stage = scoreToStage(report.knittingLevel);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300], // AppBar 배경색도 동일하게

        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            tooltip: '저장',
            onPressed: _saveToGallery,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: '공유',
            onPressed: _shareReport,
          ),
        ],
      ),

      backgroundColor: Colors.grey[300],

      body:SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, bottom: 24, right: 24, left: 24),
        child: RepaintBoundary(
          key: _captureKey,
          child: Container(
            padding: const EdgeInsets.only(top:45, bottom: 45, right: 24.0, left: 24.0),
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, //세로 정렬
              children: [
                //텍스트
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(text: '이번 주는\n'),
                      TextSpan(
                        text: '${stage["label"]} 만큼\n',
                        style: TextStyle(color: PRIMARY_COLOR), // 원하는 색상으로 변경
                      ),
                      TextSpan(text: '떴어요'),
                    ],
                  ),
                ),

                SizedBox(height: 26,),

                Image.asset(
                  stage["image"]!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: 16,),

                //사진 설명
                Text('${stage["label"]}'),
                Text('${report.knittingLevel.toStringAsFixed(1)}cm'),

                SizedBox(height: 35,),
                Divider(),
                SizedBox(height: 16,),

                //통계
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "주간 뜨개 기록",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,),
                          ),
                          Text('${report.weeklyKnittingCount}개'),
                        ],
                      ),
                      SizedBox(height: 16,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "남긴 사진",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,),
                          ),
                          Text('${report.weeklyKnittingPhotoCount}개'),
                        ],
                      ),
                      SizedBox(height: 16,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "주간 뜨개 진행도",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,),
                          ),
                          Text('${report.weeklyProgress}%'),
                        ],
                      ),
                      SizedBox(height: 16,),
                    ],
                  ),
                ),

                //가장 많이 사용한 태그
                if ((report.topTags?.isNotEmpty ?? false)) ...[
                  Divider(),
                  SizedBox(height: 16,),
                  Text("이번 주 가장 많이 사용한 태그", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,),),
                  SizedBox(height: 16,),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: report.topTags!
                        .take(2) // 최대 2개만 가져오기
                        .map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: PRIMARY_COLOR),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: PRIMARY_COLOR,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                ],

                if ((report.weeklyHashtags?.isNotEmpty ?? false)) ...[
                  Divider(),
                  SizedBox(height: 16,),
                  Text("이번 주 해시태그 요약", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,),),
                  SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: report.weeklyHashtags!.map((tag) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${tag.hashtag}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text('${tag.description}', style: TextStyle(fontSize: 14,)),
                            const SizedBox(height: 16),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}