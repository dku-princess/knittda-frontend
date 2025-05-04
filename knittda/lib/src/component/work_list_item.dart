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
          SizedBox(width: 20),//이미지와 Column 사이에 Sized Box 사용해서 공간 추가
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
        ],
      ),

    );
  }
}