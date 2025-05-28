import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/presentation/widgets/image_box.dart';

class ReportUi extends StatelessWidget {
  const ReportUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300], // AppBar 배경색도 동일하게
      ),
      backgroundColor: Colors.grey[300],

      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 16, bottom: 24, right: 24, left: 24),
        padding: const EdgeInsets.only(top:45, bottom: 45, right: 24.0, left: 24.0),
        decoration: BoxDecoration(
          color: Color(0xFFF2F2F7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, //가로 정렬
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
                      text: '강낭콩 한 알 만큼\n',
                      style: TextStyle(color: PRIMARY_COLOR), // 원하는 색상으로 변경
                    ),
                    TextSpan(text: '떴어요'),
                  ],
                ),
              ),

              SizedBox(height: 26,),

              //사진
              ImageBox(height: 200, width: double.infinity,),

              SizedBox(height: 16,),

              //사진 설명
              Text('강낭콩 한알'),
              Text('2.5cm'),

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
                        Text('3개'),
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
                        Text('45%'),
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
                        Text('5개'),
                      ],
                    ),
                    SizedBox(height: 16,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}