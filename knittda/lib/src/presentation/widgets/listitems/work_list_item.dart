import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/work_model.dart';
import '../image_box.dart';

class WorkListItem extends StatelessWidget {
  final WorkModel work;
  final VoidCallback? onTap;
  final Function()? onPressed;

  const WorkListItem({super.key, required this.work, this.onTap, this.onPressed});

  @override
  Widget build(BuildContext context) {
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
                Text(work.nickname),
                SizedBox(height:14),
                // Row(
                //   children: [
                //     Text("기록일", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                //     SizedBox(width: 4),
                //     Text(DateUtilsHelper.toDotFormat(work.lastRecordAt), style: TextStyle(fontSize: 12)),
                //   ],
                // ),
              ],
            ),
            Spacer(), // 오른쪽 끝으로 버튼을 밀어줌
            if (onPressed != null) // ✅ showButton 없이 이 조건만으로 제어
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
}
