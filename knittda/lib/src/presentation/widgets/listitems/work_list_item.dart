import 'package:flutter/material.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/models/work_model.dart';
import '../work_image_box.dart';

class WorkListItem extends StatelessWidget {
  final WorkModel work;
  final VoidCallback? onTap;
  final Function()? onPressed;

  const WorkListItem({super.key, required this.work, this.onTap, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final String lastRecordAt = _getRelativeDate(work.lastRecordAt);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300), //bottom 외각선
          ),
        ),
        child: Row(
          children: [
            WorkImageBox(
              networkUrl: work.thumbnailUrl,
              width: 60,
              height: 60,
            ),
            SizedBox(width: 10), // 이미지와 텍스트 사이 여백 추가
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(work.nickname, style: TextStyle(fontSize: 16),),
                SizedBox(height:10),
                Row(
                  children: [
                    Text("기록일", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                    SizedBox(width: 4),
                    Text(lastRecordAt, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
            Spacer(), // 오른쪽 끝으로 버튼을 밀어줌
            if (onPressed != null)
              TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  '추가',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getRelativeDate(DateTime? serverUtc) {
    if (serverUtc == null) return "-";

    // 1) UTC → KST(+9)
    DateTime _toKST(DateTime dt) => dt.toUtc().add(const Duration(hours: 9));
    final kstDateTime = _toKST(serverUtc);
    final kstNowTime  = _toKST(DateTime.now());

    // 2) 시·분·초를 0 으로 맞춰 ‘날짜만’ 비교
    final kstDate = DateTime(kstDateTime.year, kstDateTime.month, kstDateTime.day);
    final kstToday = DateTime(kstNowTime.year, kstNowTime.month, kstNowTime.day);

    final diffDays = kstToday.difference(kstDate).inDays;

    if (diffDays == 0) {
      return '오늘';
    } else if (diffDays == 1) {
      return '어제';
    } else if (diffDays < 7) {
      return '$diffDays일 전';
    } else {
      return DateUtilsHelper.toDotFormat(kstDate); // 예: 2025.07.10
    }
  }
}
