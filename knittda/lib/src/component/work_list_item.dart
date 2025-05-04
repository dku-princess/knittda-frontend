import 'package:flutter/material.dart';
import 'image_box.dart';

class WorkListItem extends StatelessWidget {
  final String? url;
  final String name;
  final String date;

  WorkListItem({
    required this.url,
    required this.name,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    print("test");
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300), //bottom 외각선
        ),
      ),
      child: Row(
        children: [
          ImageBox(url),
          SizedBox(width: 20), // 이미지와 텍스트 사이 여백 추가
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name),
              Row(
                children: [
                  Text("기록일", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  Text(date, style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          Spacer(), // 오른쪽 끝으로 버튼을 밀어줌
          GestureDetector( //추가 버튼
            onTap: () {
              /*
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDiaryPage()),
              );*/
            },
            child: Container(
              width: 40,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.grey[300], // 배경 색상
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center, // 텍스트 중앙 정렬
              child: Text(
                '추가',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
