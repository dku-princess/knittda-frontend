import 'package:flutter/material.dart';
import '../image_box.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: InkWell(
        onTap: (){
          //작품 상세 페이지로 이동
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
                  SizedBox(height:14),
                  Row(
                    children: [
                      Text("기록일", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      SizedBox(width: 4),
                      Text(date, style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
              Spacer(), // 오른쪽 끝으로 버튼을 밀어줌
              TextButton(
                onPressed: (){
                  //작품 기록 추가로 이동
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  minimumSize: Size(0, 0), // 최소 크기 제거
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역 최소화
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
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
      ),
    );
  }
}
