import 'package:flutter/material.dart';

class Mypage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            '마이 페이지',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //가로방향: 좌측정렬
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300), //bottom 외각선
                ),
              ),
              child: Row(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "홍길동",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: (){
                      //프로필 수정으로 이동
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: Text(
                      '프로필 수정',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 26),
            // 연결된 계정
            Text(
              "연결된 계정",
              style: TextStyle(
                fontSize: 16,
                //fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "test@test.com",
            ),
          ],
        ),
      )
    );
  }
}