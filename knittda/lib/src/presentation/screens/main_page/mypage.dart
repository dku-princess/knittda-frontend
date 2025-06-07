import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/user_view_model.dart';

class Mypage extends StatelessWidget {
  const Mypage({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<UserViewModel>();

    if (!userViewModel.isReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
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
                    backgroundImage: userViewModel.profileImage,
                    backgroundColor: Colors.grey,
                  ),
                      const SizedBox(width: 12),
                      Text(
                        userViewModel.nickname,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  // Spacer(),
                  // TextButton(
                  //   onPressed: (){
                  //     //프로필 수정으로 이동
                  //   },
                  //   style: TextButton.styleFrom(
                  //     backgroundColor: Colors.grey[300],
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: const BorderRadius.all(Radius.circular(8)),
                  //     ),
                  //   ),
                  //   child: Text(
                  //     '프로필 수정',
                  //     style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  //   ),
                  // ),
                ],
              ),
            ),
            // SizedBox(height: 26),
            // // 연결된 계정
            // Text(
            //   "연결된 계정",
            //   style: TextStyle(
            //     fontSize: 16,
            //     //fontWeight: FontWeight.w600,
            //   ),
            // ),
            // SizedBox(height: 16),
            // Text(userViewModel.email),
          ],
        ),
      )
    );
  }
}