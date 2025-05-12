import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      padding: EdgeInsets.only(top: 26, right: 40, left: 40),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                      "도안"
                  ),
                ),
                Expanded(child: Text("벤쿠버가디건")),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                      "작가"
                  ),
                ),
                Expanded(child: Text("김대리")),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                      "사이즈"
                  ),
                ),
                Expanded(child: Text("m")),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                      "실"
                  ),
                ),
                Expanded(child: Text("열매달이틀 스카이")),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                      "실 사용량"
                  ),
                ),
                Expanded(child: Text("340g")),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                      "게이지"
                  ),
                ),
                Expanded(child: Text("24코 30단")),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                      "바을"
                  ),
                ),
                Expanded(child: Text("치아오구 4mm")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}