import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/presentation/view_models/work_view_model.dart';
import 'package:provider/provider.dart';

class Info extends StatelessWidget {
  final WorkModel work;

  const Info({super.key, required this.work});

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
                Expanded(child: Text("정보 받아와야됨")),
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
                Expanded(child: Text("정보 받아와야 됨")),
              ],
            ),
          ),
          work.customYarnInfo == null
              ?  SizedBox()
              : Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                      "실"
                  ),
                ),
                Expanded(child: Text(work.customYarnInfo!)),
              ],
            ),
          ),
          work.customNeedleInfo == null
              ?  SizedBox()
              : Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                      "바늘"
                  ),
                ),
                Expanded(child: Text(work.customNeedleInfo!)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}