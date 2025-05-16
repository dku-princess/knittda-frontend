import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/view_models/work_view_model.dart';
import 'package:provider/provider.dart';

class Info extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final workVM = context.watch<WorkViewModel>();
    final work = workVM.gotWork;

    if (workVM.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (workVM.errorMessage != null) {
      return Center(child: Text('에러 발생: ${workVM.errorMessage}'));
    }

    if (work == null) {
      return Center(child: Text('기록이 없습니다.'));
    }

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
                Expanded(child: Text("열매달이틀 스카이")),
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
                Expanded(child: Text("치아오구 4mm")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}