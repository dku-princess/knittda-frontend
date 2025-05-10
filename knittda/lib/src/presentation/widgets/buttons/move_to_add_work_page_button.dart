import 'package:flutter/material.dart';

//work_list_item 밑에 배치되는 +버튼(누를 시 AddWorkPage로 이동)


class MoveToAddWorkPageButton extends StatefulWidget {
  const MoveToAddWorkPageButton({super.key});

  @override
  State<MoveToAddWorkPageButton> createState() => _MoveToAddWorkPageButton();
}

class _MoveToAddWorkPageButton extends State<MoveToAddWorkPageButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // 버튼을 가운데 정렬
      children: [
        GestureDetector(
          onTap: () {
            /*
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddWorkPage()),
            ).then((_) {
              // AddWorkPage에서 돌아온 후 화면을 다시 그린다
              setState(() {});
            });

             */
          },
          child: Container(
            width: MediaQuery.of(context).size.width - (120),
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
