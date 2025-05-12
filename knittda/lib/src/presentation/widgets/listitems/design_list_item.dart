import 'package:flutter/material.dart';
import '../image_box.dart';

class DesignListItem extends StatelessWidget {
  final String? url;
  final String title;
  final String designer;

  DesignListItem({
    this.url,
    required this.title,
    required this.designer,
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                  SizedBox(height:9),
                  Text(
                    designer,
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            ImageBox(url),
          ],
        ),
      ),
    );
  }
}