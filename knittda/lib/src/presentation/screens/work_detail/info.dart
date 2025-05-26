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
                      (work.designDto?.title?.trim().isEmpty ?? true)
                          ? '정보를 추가해 주세요'
                          : work.designDto!.title!,
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
                      (work.designDto?.designer?.trim().isEmpty ?? true)
                          ? '정보를 추가해 주세요'
                          : work.designDto!.designer!,
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
                      (work.customYarnInfo?.trim().isEmpty ?? true)
                          ? '정보를 추가해 주세요'
                          : work.customYarnInfo!,
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
                      (work.customNeedleInfo?.trim().isEmpty ?? true)
                         ? '정보를 추가해 주세요'
                         : work.customNeedleInfo!,
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