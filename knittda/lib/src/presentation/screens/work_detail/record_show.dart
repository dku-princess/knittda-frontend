import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/models/record_model.dart';

class RecordShow extends StatelessWidget {
  final RecordModel record;
  const RecordShow({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 3; //화면의 1/3
    final dateStr = DateUtilsHelper.toDotFormat(record.recordedAt!);
    final timeStr = DateUtilsHelper.toHourMinuteFormat(record.recordedAt!);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          //이미지
          if (true)
            Container(
              height: height, // 높이를 화면 1/3로 고정
              width: double.infinity, // 가로를 화면 가득 채움
              color: Colors.grey,
            ),
          const SizedBox(height: 16),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.0),
            child: Column(
              children: [
                //시간
                Row(
                  children: [
                    Text(dateStr, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    SizedBox(width: 10,),
                    Text(timeStr, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 16),

                //comment
                if (record.comment != null && record.comment!.isNotEmpty) ...[
                  Text(
                    record.comment ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                ],

                // 태그
                if (record.tags != null && record.tags!.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: record.tags!.map((tag) {
                        return Container(
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
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}