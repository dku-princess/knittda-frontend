import 'package:flutter/material.dart';
import 'AddWorkPage.dart'; // AddWorkPage 임포트 경로 수정
import 'AddDiaryPage.dart'; // AddDiaryPage 임포트 경로 추가

class WorkList extends StatefulWidget {
  @override
  _WorkListState createState() => _WorkListState();
}

class _WorkListState extends State<WorkList> {
  List<Widget> workItems = []; // 작업 목록을 저장할 리스트

  @override
  void initState() {
    super.initState();
    // 초기 작업 목록 추가
    _addWorkItem();
  }

  // 작업 목록 아이템을 생성하는 함수
  Widget _buildWorkItem() {
    return Container(
      width: 315,
      height: 80,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6E6E6)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 10,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://placehold.co/60x60"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            left: 80,
            top: 14,
            child: Text(
              '노프릴',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            left: 80,
            top: 51,
            child: Text(
              '기록일 3일전',
              style: TextStyle(
                color: const Color(0xFF4D4D4D),
                fontSize: 12,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 26,
            child: GestureDetector( // GestureDetector로 감싸기
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddDiaryPage()), // AddDiaryPage()로 수정
                ).then((_) {
                  // AddDiaryPage에서 돌아온 후 화면을 다시 그립니다.
                  setState(() {});
                });
              },
              child: Container(
                width: 40,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '추가',
                    style: TextStyle(
                      color: const Color(0xFFA6A6A6),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 작업 목록 아이템 추가 함수
  void _addWorkItem() {
    setState(() {
      workItems.add(_buildWorkItem());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 375,
          height: 812,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 30,
                top: 47,
                child: Text(
                  '나의 \n뜨개 작품',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 728,
                child: Container(
                  width: 375,
                  height: 88,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 145,
                child: Container(
                  width: 315,
                  height: 44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF0ABE8C)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '뜨고 있어요',
                          style: TextStyle(
                            color: const Color(0xFF0ABE8C),
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        '다 떴어요',
                        style: TextStyle(
                          color: const Color(0xFF666666),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 45,
                top: 521,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddWorkPage()),
                    ).then((_) {
                      // AddWorkPage에서 돌아온 후 화면을 다시 그립니다.
                      setState(() {});
                    });
                  },
                  child: Container(
                    width: 284,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Icon(Icons.add, color: Colors.black),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 229,
                // SingleChildScrollView로 감싸서 스크롤 가능하게 변경
                child: SizedBox(
                  height: 280, // 스크롤 가능한 영역의 높이 설정 (적절하게 조절)
                  child: SingleChildScrollView(
                    child: Column(
                      children: workItems,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



