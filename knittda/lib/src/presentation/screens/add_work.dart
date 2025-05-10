import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/form/custom_text_field.dart';
import 'package:knittda/src/presentation/view_models/add_work_view_model.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/core/constants/color.dart';

class AddWorkPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final addWorkViewModel = context.watch<AddWorkViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('작품 추가', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: addWorkViewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "기본 정보",
                  style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          CustomTextField(hintText: "작품이름",),
                          SizedBox(height: 16),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    //padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(color: PRIMARY_COLOR),
                                    ),
                                    foregroundColor: PRIMARY_COLOR, // 텍스트 색상
                                    backgroundColor: Colors.transparent, // 배경 투명
                                  ),
                                  child: Text(
                                    "시작 날짜",
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    //padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(color: PRIMARY_COLOR),
                                    ),
                                    foregroundColor: PRIMARY_COLOR, // 텍스트 색상
                                    backgroundColor: Colors.transparent, // 배경 투명
                                  ),
                                  child: Text(
                                    "목표 날짜",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 50),
                Text(
                  "뜨개 정보",
                  style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20,),
                CustomTextField(label: "도안",),
                SizedBox(height: 16,),
                CustomTextField(label: "작가",),
                SizedBox(height: 16,),
                // CustomTextField(label: "사이즈",),
                // SizedBox(height: 16,),
                CustomTextField(label: "실",),
                SizedBox(height: 16,),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: 80,
                //       child: Text("실 사용량"),
                //     ),
                //     Expanded(
                //       child: CustomTextField(),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 16,),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: 80,
                //       child: Text("게이지"),
                //     ),
                //     Expanded(
                //       child: CustomTextField(),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 16,),
                CustomTextField(label: "바늘",),
              ],
            ),
          ),
        ),
      ),
    );
  }
}