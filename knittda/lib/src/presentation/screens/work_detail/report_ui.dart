import 'dart:io';
import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/presentation/view_models/report_view_model.dart';
import 'package:knittda/src/utils/capture_util.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

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
    orElse: () => {"label": "범위를 벗어남", "image": null},
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
  static const platform = MethodChannel("com.knittda/image_saver");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportViewModel>().fetchReport();
    });
  }

  Future<void> _saveReportImage() async {
    final bytes = await captureWidget(captureKey);
    if (bytes != null) {
      await platform.invokeMethod("saveImage", {"bytes": bytes});
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("리포트가 저장되었습니다!")),
        );
      }
    }
  }

  Future<void> _shareToKakao() async {
    final bytes = await captureWidget(captureKey);
    if (bytes != null) {
      final success = await platform.invokeMethod("saveImage", {"bytes": bytes});
      if (success == true) {
        await platform.invokeMethod("shareKakao");
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("이미지 저장 실패")),
          );
        }
      }
    }
  }

  Future<void> _shareReportImage() async {
    final bytes = await captureWidget(captureKey);
    if (bytes != null) {
      try {
        await platform.invokeMethod('shareImage', {'bytes': bytes});
      } on PlatformException catch (e) {
        debugPrint("iOS 공유 오류: ${e.message}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final reportVM = context.watch<ReportViewModel>();
    final report = reportVM.report;
    final isLoading = reportVM.isLoading;
    final error = reportVM.error;

    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text('에러: $error'));
    if (report == null) return const Center(child: Text('데이터 없음'));

    final stage = scoreToStage(report.knittingLevel);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _saveReportImage,
            tooltip: "이미지 저장",
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: Platform.isIOS ? _shareReportImage : _shareToKakao,
            tooltip: "카카오톡으로 공유",
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: captureKey,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 24),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                      children: [
                        const TextSpan(text: '이번 주는\n'),
                        TextSpan(text: '${stage["label"]} 만큼\n', style: TextStyle(color: PRIMARY_COLOR)),
                        const TextSpan(text: '떴어요'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 26),
                  if (stage["image"] != null)
                    Image.asset(stage["image"]!, height: 200, width: double.infinity, fit: BoxFit.contain),
                  const SizedBox(height: 16),
                  Text(stage["label"] ?? ''),
                  Text('${report.knittingLevel}cm'),
                  const SizedBox(height: 35),
                  const Divider(),
                  const SizedBox(height: 16),
                  _stat("주간 뜨개 기록", "${report.weeklyKnittingCount}개"),
                  _stat("남긴 사진", "${report.weeklyKnittingPhotoCount}개"),
                  _stat("주간 뜨개 진행도", "${report.weeklyProgress}%"),
                  if ((report.topTags?.isNotEmpty ?? false)) ...[
                    const Divider(),
                    const SizedBox(height: 16),
                    const Text("이번 주 가장 많이 사용한 태그", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: report.topTags!
                          .take(2)
                          .map((tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: PRIMARY_COLOR),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(tag, style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.w500, fontSize: 12)),
                      ))
                          .toList(),
                    ),
                  ],
                  if ((report.weeklyHashtags?.isNotEmpty ?? false)) ...[
                    const Divider(),
                    const SizedBox(height: 16),
                    const Text("이번 주 해시태그 요약", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    ...report.weeklyHashtags!.map((tag) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tag.hashtag ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(tag.description ?? '', style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    )),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _stat(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        Text(value),
      ],
    ),
  );
}
