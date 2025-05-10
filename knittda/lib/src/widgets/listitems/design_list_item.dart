import 'package:flutter/material.dart';
import '../image_box.dart';

class DesignListItem extends StatelessWidget {
  final String? url;
  final String name;

  DesignListItem({
    required this.url,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //작품 추가 페이지로 이동
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300), //bottom 외각선
          ),
        ),
        child: Row(
          children: [
            ImageBox(url),
            SizedBox(width: 10), // 이미지와 텍스트 사이 여백 추가
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
              ],
            ),
            Spacer(), // 오른쪽 끝으로 버튼을 밀어줌

          ],
        ),
      ),
    );
  }
}