import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/knittda_snack_bar.dart';
import 'package:knittda/src/presentation/widgets/knittda_app_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/data/data_sources/analytics_service.dart';
import 'package:knittda/src/presentation/report/report_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:knittda/src/core/theme/theme.dart';

final List<Map<String, dynamic>> scoreRanges = [
  {
    "min": 0,
    "max": 0,
    "label": "조쥐",
    "image": "assets/image/stage/stage1.png",
  },
  {
    "min": 1,
    "max": 10,
    "label": "까부기",
    "image": "assets/image/stage/stage2.png",
  },
  {
    "min": 11,
    "max": 20,
    "label": "쿨냥이",
    "image": "assets/image/stage/stage3.png",
  },
  {
    "min": 21,
    "max": 30,
    "label": "오구리",
    "image": "assets/image/stage/stage4.png",
  },
  {
    "min": 31,
    "max": 40,
    "label": "복토",
    "image": "assets/image/stage/stage5.png",
  },
  {
    "min": 41,
    "max": 50,
    "label": "개르시",
    "image": "assets/image/stage/stage6.png",
  },
  {
    "min": 51,
    "max": 60,
    "label": "고솜이",
    "image": "assets/image/stage/stage7.png",
  },
  {
    "min": 61,
    "max": 70,
    "label": "으아거",
    "image": "assets/image/stage/stage8.png",
  },
  {
    "min": 71,
    "max": double.infinity,
    "label": "과묵한 오소리",
    "image": "assets/image/stage/stage9.png",
  },
];

Map<String, String?> scoreToStage(double score) {
  for (final r in scoreRanges) {
    final double min = (r["min"] as num).toDouble();
    final double max = (r["max"] as num).toDouble();
    if (score >= min && score <= max) {
      return {"label": r["label"] as String, "image": r["image"] as String?};
    }
  }
  return {"label": "범위를 벗어남", "image": null};
}

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final GlobalKey _captureKey = GlobalKey();

  Future<bool> _ensureGalleryPermission() async {
    try {
      final has = await Gal.hasAccess(toAlbum: true);
      if (has) return true;

      final granted = await Gal.requestAccess(toAlbum: true);
      if (!granted) {
        if (!mounted) return false;
        KnittdaSnackBar.show(context, '사진 접근 권한이 없어 저장할 수 없어요. 설정에서 권한을 허용해 주세요.', tone: KnittdaSnackTone.error);
      }
      return granted;
    } catch (e) {
      if (!mounted) return false;
      KnittdaSnackBar.show(context, '권한 확인 중 오류가 발생했어요: $e', tone: KnittdaSnackTone.error);
      return false;
    }
  }

  Future<Uint8List?> _capture() async {
    final ctx = _captureKey.currentContext;
    if (ctx == null) return null;

    final boundary = ctx.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return null;

    final rawDpr =
        View.maybeOf(ctx)?.devicePixelRatio ??
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    final start = rawDpr.clamp(1.0, 3.0);

    await WidgetsBinding.instance.endOfFrame;
    if (!mounted || !boundary.attached) return null;

    final size = boundary.size;
    final maxSide = size.width > size.height ? size.width : size.height;
    final maxSafeRatio = maxSide > 0 ? (4096.0 / maxSide) : 1.0;
    final r = start > maxSafeRatio ? maxSafeRatio : start;

    final image = await boundary.toImage(pixelRatio: r);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  // 저장 버튼 로직
  Future<void> _saveToGallery() async {
    try {
      if (!await _ensureGalleryPermission()) return;

      final bytes = await _capture();
      if (bytes == null) {
        if (!mounted) return;
        KnittdaSnackBar.show(context, '이미지 캡처에 실패했어요. 잠시 후 다시 시도해 주세요.', tone: KnittdaSnackTone.error);
        return;
      }

      await Gal.putImageBytes(bytes, album: 'KnittingReport');

      if (!mounted) return;
      KnittdaSnackBar.show(context, '갤러리에 저장되었습니다!', tone: KnittdaSnackTone.success);
    } catch (e) {
      if (!mounted) return;
      KnittdaSnackBar.show(context, '저장 중 오류가 발생했어요: $e', tone: KnittdaSnackTone.error);
    }
  }

  // 공유 버튼 로직
  Future<void> _shareReport(BuildContext anchorContext) async {
    try {
      final box = context.findRenderObject() as RenderBox?;
      if (box == null) return;

      final bytes = await _capture();
      if (bytes == null) {
        if (!mounted) return;
        KnittdaSnackBar.show(context, '이미지 캡처에 실패했어요. 잠시 후 다시 시도해 주세요.', tone: KnittdaSnackTone.error);
        return;
      }

      final dir = await getTemporaryDirectory();
      final file = await File(
        '${dir.path}/report_${DateTime.now().millisecondsSinceEpoch}.png',
      ).writeAsBytes(bytes);

      AnalyticsService.instance.logShare('report', 'weekly_report');
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: '이번 주 뜨개 리포트',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      KnittdaSnackBar.show(context, '공유 중 오류가 발생했어요: $e', tone: KnittdaSnackTone.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ReportViewModel>();
    final state = viewModel.state;
    final report = state.report;

    final stage = (!state.isLoading && report != null)
        ? scoreToStage(report.knittingLevel)
        : null;

    final String? stageImage = stage?["image"];

    return Scaffold(
      appBar: KnittdaAppBar(
        backgroundColor: AppColors.grey200,

        actions: [
          if (!state.isLoading && report != null) ...[
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  onPressed: _saveToGallery,
                  tooltip: '저장',
                  icon: const Icon(Icons.save_alt),
                );
              },
            ),
            Builder(
              builder: (BuildContext buttonContext) {
                return IconButton(
                  onPressed: () => _shareReport(buttonContext),
                  tooltip: '공유',
                  icon: const Icon(Icons.share),
                );
              },
            ),
          ],
        ],
      ),

      backgroundColor: AppColors.grey200,

      body: state.isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("주간 리포트 불러오는 중..."),
                  SizedBox(height: AppSpacing.space24),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : report == null
          ? const Center(child: Text('주간 리포트를 불러오지 못 했어요'))
          : SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: AppSpacing.space16,
                bottom: AppSpacing.space24,
                right: AppLayout.screenPaddingH,
                left: AppLayout.screenPaddingH,
              ),
              child: RepaintBoundary(
                key: _captureKey,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 45,
                    bottom: 45,
                    right: AppSpacing.space24,
                    left: AppSpacing.space24,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(AppRadius.button),
                  ),
                  child: Column(
                    children: [
                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          style: TextStyle(
                            fontSize: AppFontSize.display,
                            fontWeight: AppFontWeight.bold,
                          ),
                          children: [
                            TextSpan(text: '이번 주는\n'),
                            TextSpan(
                              text: '${stage?["label"]}만큼\n',
                              style: TextStyle(color: PRIMARY_COLOR),
                            ),
                            TextSpan(text: '떴어요'),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSpacing.space24),

                      if (stageImage != null)
                        AspectRatio(
                          aspectRatio: 4 / 3, // width : height
                          child: Image.asset(stageImage, fit: BoxFit.contain),
                        ),
                      SizedBox(height: AppSpacing.space16),

                      Text('${stage?["label"]}'),
                      Text('${report.knittingLevel}cm'),

                      SizedBox(height: 35),
                      Divider(),
                      SizedBox(height: AppSpacing.space16),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "주간 기록",
                                  style: TextStyle(
                                    fontSize: AppFontSize.md,
                                    fontWeight: AppFontWeight.semibold,
                                  ),
                                ),
                                Text('${report.weeklyKnittingCount}개'),
                              ],
                            ),
                            SizedBox(height: AppSpacing.space16),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "남긴 사진",
                                  style: TextStyle(
                                    fontSize: AppFontSize.md,
                                    fontWeight: AppFontWeight.semibold,
                                  ),
                                ),
                                Text('${report.weeklyKnittingPhotoCount}개'),
                              ],
                            ),
                            SizedBox(height: AppSpacing.space16),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "주간 진행도",
                                  style: TextStyle(
                                    fontSize: AppFontSize.md,
                                    fontWeight: AppFontWeight.semibold,
                                  ),
                                ),
                                Text('${report.weeklyProgress}%'),
                              ],
                            ),
                            SizedBox(height: AppSpacing.space16),
                          ],
                        ),
                      ),

                      if ((report.topTags?.isNotEmpty ?? false)) ...[
                        Divider(),
                        SizedBox(height: AppSpacing.space16),
                        Text(
                          "이번 주 가장 많이 사용한 태그",
                          style: TextStyle(
                            fontSize: AppFontSize.lg,
                            fontWeight: AppFontWeight.semibold,
                          ),
                        ),
                        SizedBox(height: AppSpacing.space16),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: report.topTags!
                              .take(2)
                              .map(
                                (tag) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.space8,
                                    vertical: AppSpacing.space8,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: PRIMARY_COLOR),
                                    borderRadius: BorderRadius.circular(AppRadius.pill),
                                  ),
                                  child: Text(
                                    tag,
                                    style: TextStyle(
                                      color: PRIMARY_COLOR,
                                      fontWeight: AppFontWeight.medium,
                                      fontSize: AppFontSize.sm,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: AppSpacing.space16),
                      ],

                      if ((report.weeklyHashtags?.isNotEmpty ?? false)) ...[
                        Divider(),
                        SizedBox(height: AppSpacing.space16),
                        Text(
                          "이번 주 해시태그 요약",
                          style: TextStyle(
                            fontSize: AppFontSize.lg,
                            fontWeight: AppFontWeight.semibold,
                          ),
                        ),
                        SizedBox(height: AppSpacing.space16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: report.weeklyHashtags!.map((tag) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${tag.hashtag}',
                                    style: const TextStyle(
                                      fontSize: AppFontSize.lg,
                                      fontWeight: AppFontWeight.semibold,
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.space4),
                                  Text(
                                    '${tag.description}',
                                    style: TextStyle(fontSize: AppFontSize.md),
                                  ),
                                  const SizedBox(height: AppSpacing.space16),
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
