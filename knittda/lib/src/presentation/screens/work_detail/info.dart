import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/work_model.dart';

class Info extends StatelessWidget {
  final WorkModel work;

  const Info({super.key, required this.work});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    "도안",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Text(
                      (work.design?.title?.trim().isEmpty ?? true)
                          ? '정보를 추가해 주세요'
                          : work.design!.title!,
                      style: TextStyle(fontSize: 16)
                  ),
                ),
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
                      "작가",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Text(
                      (work.design?.designer?.trim().isEmpty ?? true)
                          ? '정보를 추가해 주세요'
                          : work.design!.designer!,
                      style: TextStyle(fontSize: 16)
                  ),
                ),
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
                      "실",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Text(
                      (work.design?.yarnInfo?.trim().isEmpty ?? true)
                          ? '정보를 추가해 주세요'
                          : work.design!.yarnInfo!,
                      style: TextStyle(fontSize: 16)
                  ),
                ),
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
                      "바늘",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Text(
                      (work.design?.needleInfo?.trim().isEmpty ?? true)
                         ? '정보를 추가해 주세요'
                         : work.design!.needleInfo!,
                      style: TextStyle(fontSize: 16)
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}