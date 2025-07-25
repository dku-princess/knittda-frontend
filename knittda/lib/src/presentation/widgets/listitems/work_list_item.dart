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
            work.thumbnailUrl != null && work.thumbnailUrl!.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                work.thumbnailUrl!,
                height: 60,
                width: 60,
                fit: BoxFit.cover,

                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                },

                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
                  );
                },
              ),
            ) : ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                height: 60,
                width: 60,
                child: Container(
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
                ),
              ),
            ),
            SizedBox(width: 10), // 이미지와 텍스트 사이 여백 추가
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(work.nickname, style: TextStyle(fontSize: 16),),
                SizedBox(height:14),
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

    // 서버에서 받은 UTC를 KST로 변환
    DateTime toKST(DateTime dt) {
      return dt.add(const Duration(hours: 9));
    }

    final kstServerTime = toKST(serverUtc);
    final kstNow = DateTime.now(); // 현재 로컬 시간대 (KST 환경이라면 OK)

    // 날짜 부분만 비교 (시·분·초 제거)
    final kstServerDate = DateTime(kstServerTime.year, kstServerTime.month, kstServerTime.day);
    final kstToday = DateTime(kstNow.year, kstNow.month, kstNow.day);

    final diffDays = kstServerDate.difference(kstToday).inDays;

    if (diffDays == 0) {
      return '오늘';
    } else if (diffDays == -1) {
      return '어제';
    } else if (diffDays < 0 && diffDays >= -6) {
      return '${-diffDays}일 전';
    } else {
      return DateUtilsHelper.toDotFormat(kstServerDate); // 예: 2025.07.10
    }
  }
}
