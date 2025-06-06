import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/presentation/view_models/record_view_model.dart';
import 'package:provider/provider.dart';

int statusToPercent(String? status) {
  switch (status) {
    case 'NOT_STARTED':
      return 0;
    case 'STARTED':
      return 25;
    case 'IN_PROGRESS':
      return 50;
    case 'ALMOST_DONE':
      return 75;
    case 'COMPLETED':
      return 100;
    default:
      return 0; // 기본값 처리
  }
}

class Report extends StatelessWidget {
  final WorkModel work;
  const Report({super.key, required this.work});

  @override
  Widget build(BuildContext context) {
    final recordVM = context.watch<RecordViewModel>();
    final records = recordVM.records ?? [];

    final latestRecord = records.isNotEmpty ? records.last : null;
    final percent = statusToPercent(latestRecord?.recordStatus);
    final fillFraction = percent / 100.0;

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime startDate = DateTime(work.startDate!.year, work.startDate!.month, work.startDate!.day);
    DateTime goalDate = DateTime(work.goalDate!.year, work.goalDate!.month, work.goalDate!.day);

    // D+ 계산
    int dDayPlus = today.difference(startDate).inDays;

    // D-Day 텍스트 계산
    int dayDiff = goalDate.difference(today).inDays;

    String dDayText;
    if (dayDiff > 0) {
      dDayText = 'D - $dayDiff';
    } else if (dayDiff == 0) {
      dDayText = 'D - 0';
    } else {
      dDayText = 'D + ${dayDiff.abs()}';
    }

    String formattedStartDate = DateUtilsHelper.toDotFormat(startDate);
    String formattedGoalDate = DateUtilsHelper.toDotFormat(goalDate);

    return Padding(
      padding: EdgeInsets.all(26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "나의 진행도",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 26,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // 그라데이션 채움 (아래서부터 비율만큼 높이)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: fillFraction, // 0.0 ~ 1.0
                        widthFactor: 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: percent == 100
                                ? BorderRadius.circular(10) // 전체 둥글게
                                : BorderRadius.vertical(bottom: Radius.circular(10)), // 아래만
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFEEEEEE),
                                PRIMARY_COLOR,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // 텍스트
                    Center(
                      child: Text(
                        '$percent%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 150,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'D + $dDayPlus\n',
                            style: TextStyle(color: PRIMARY_COLOR, fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                              text: formattedStartDate,
                              style: TextStyle(color: Colors.grey[600], fontSize: 12,)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '$dDayText\n',
                            style: TextStyle(
                              color: PRIMARY_COLOR,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: formattedGoalDate,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}