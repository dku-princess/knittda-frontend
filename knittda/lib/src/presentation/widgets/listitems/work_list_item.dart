import 'package:flutter/material.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/models/work_model.dart';
import '../image_box.dart';

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
            ImageBox(
              networkImageUrl: work.image?.imageUrl,
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
                    Text(lastRecordAt, style: TextStyle(fontSize: 12)),
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

  String _getRelativeDate(DateTime? date) {
    if (date == null) return "-";

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return '오늘';
    } else if (difference.inDays == 1) {
      return '어제';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return DateUtilsHelper.toDotFormat(date);
    }
  }
}
