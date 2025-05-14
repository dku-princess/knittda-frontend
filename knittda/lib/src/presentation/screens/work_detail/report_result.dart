import 'package:flutter/material.dart';

class ReportResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Container(
          width: 375,
          height: 812,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: const Color(0xFF0ABE8C)),
          child: Stack(
            children: [
              Positioned(
                left: 30,
                top: 92,
                child: Text(
                  '뜨뜨\n뜨개 리포트',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Positioned(
                left: 41,
                top: 208,
                child: Container(
                  width: 293,
                  height: 436,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 56,
                top: 222,
                child: Container(
                  width: 263,
                  height: 409,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        color: const Color(0xFF050404),
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 8,
                top: 46,
                child: Container(
                  width: 40,
                  height: 40,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://placehold.co/40x40"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
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