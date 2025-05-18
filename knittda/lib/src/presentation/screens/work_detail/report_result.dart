import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';


class ReportResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: const Color(0xFF0ABE8C)),
            child: Stack(
              children: [
                Positioned(
                  left: 30,
                  top: 92,
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      '뜨뜨\n뜨개 리포트',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
                Positioned(
                  left: 41,
                  top: 208,
                  child: Container(
                    width: 293,
                    height: 436,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 56,
                  top: 222,
                  child: CustomPaint(
                    size: Size(263, 409),
                    painter: DashedBorderPainter(), // 점선 테두리 적용
                    child: Container(
                      width: 263,
                      height: 409,
                      color: Colors.white, // 내부 색상 유지
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 오른쪽 위 X 버튼 (뒤로 가기)
          Positioned(
            right: 16,
            top: 50,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // 이전 페이지로 이동
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.close, color: Colors.black, size: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 🔹 점선 테두리 CustomPainter
class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(24),
      ));

    Path dashedPath = Path();
    for (PathMetric metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        dashedPath.addPath(metric.extractPath(distance, distance + 10), Offset.zero);
        distance += 15; // 점선 길이 및 간격 조정
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
