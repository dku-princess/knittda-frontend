import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:intl/intl.dart'; // 날짜 포맷을 위해 추가
import 'report_result.dart';

class Report extends StatelessWidget {
  final WorkModel work;
  const Report({super.key, required this.work});

  @override
  Widget build(BuildContext context) {
    print('startDate: ${work.startDate}');
    print('goalDate: ${work.endDate}');
    DateTime now = DateTime.now();
    DateTime? startDate = work.startDate;
    DateTime? goalDate = work.endDate;

    int? dDayPlus = startDate != null ? now.difference(startDate).inDays : null;
    int? dDayMinus = goalDate != null ? goalDate.difference(now).inDays : null;

    String formattedStartDate = startDate != null ? DateFormat('yy.MM.dd').format(startDate) : '';
    String formattedGoalDate = goalDate != null ? DateFormat('yy.MM.dd').format(goalDate) : '';

    bool isDateAvailable = startDate != null && goalDate != null;

    return Container(
      width: 375,
      height: 512,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Stack(
        children: [
          Positioned(
            left: 30,
            top: 20,
            child: SizedBox(
              width: 115,
              height: 34,
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
          if (isDateAvailable)
            Positioned(
              left: 195,
              top: 74,
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
                      'D + $dDayPlus',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF00A367),
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      formattedStartDate,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'D - $dDayMinus',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF00A367),
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      formattedGoalDate,
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
            left: isDateAvailable ? 30 : 112,
            top: 74,
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
                    '진행도',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '33%',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF00A367),
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 150,
                    height: 55,
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
            top: 229,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportResult()),
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
    );
  }
}
