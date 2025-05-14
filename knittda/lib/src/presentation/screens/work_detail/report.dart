import 'package:flutter/material.dart';
import 'report_result.dart';



class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    return Column(
      children: [


        Container(
          width: 375,
          height: 812,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [




              Positioned(
                left: 30,
                top: 284,
                child: SizedBox(
                  width: 115,
                  height: 24,
                  child: Text(
                    '나의 진행도',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),


              Positioned(
                left: 195,
                top: 324,
                child: Container(
                  width: 150,
                  height: 120,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF0F0F0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'D + 20',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF00A367),
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 5), // 간격 조정
                      Text(
                        '25.03.24',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 10), // 간격 조정
                      Text(
                        'D - 55',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF00A367),
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 5), // 간격 조정
                      Text(
                        '25.03.24',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              Positioned(
                left: 30,
                top: 324,
                child: Container(
                  width: 150,
                  height: 165, // 기존 높이(120 + 45)를 합침
                  decoration: ShapeDecoration(
                    color: Color(0xFFF0F0F0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '진행도',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5), // 간격 조정
                      Text(
                        '33%',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF00A367),
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 5), // 간격 조정
                      Container(
                        width: 150,
                        height: 45,
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.50, 0.00),
                            end: Alignment(0.50, 1.00),
                            colors: [Color(0xFFF0F0F0), Color(0xFF0ABE8C)],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              Positioned(
                left: 48,
                top: 489,
                child: GestureDetector(
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReportResult()), // 예제: projectId 값 추가
                    );
                  },
                  child: Container(
                    width: 281,
                    height: 48,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.09, -0.71),
                        end: Alignment(0.95, 1.50),
                        colors: [Color(0xFF8BD5BA), Color(0xFF46BC90), Color(0xFF00A367)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '뜨개 리포트 만들기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );


    return Center(child: Text('리포트'));
  }
}