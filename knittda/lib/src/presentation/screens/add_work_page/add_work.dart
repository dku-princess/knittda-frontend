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
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey, // 테두리 색상
                              ),
                            ),
                            child: CustomTextField(
                              hintText: "작품이름",
                              controller: addWorkViewModel.nicknameController,
                              validator: (val) => addWorkViewModel.nicknameValidator(val),
                            ),
                          ),
                          SizedBox(height: 10),
                          FormField<String>(
                            initialValue: addWorkViewModel.goalDate,
                            validator: addWorkViewModel.goalDateValidator,
                            builder: (FormFieldState<String> field) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      await addWorkViewModel.pickGoalDate(context);
                                      field.didChange(addWorkViewModel.goalDate); // 중요: 상태 갱신
                                    },
                                    style: TextButton.styleFrom(
                                      //padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(color: PRIMARY_COLOR),
                                      ),
                                      foregroundColor: PRIMARY_COLOR,
                                    ),
                                    child: Text(addWorkViewModel.goalDate ?? "목표 날짜"),
                                  ),
                                  if (field.hasError)
                                    Text(
                                      field.errorText ?? '',
                                      style: TextStyle(color: Colors.red, fontSize: 12),
                                    ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 50),
                Text(
                  "정보",
                  style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16),

                Text(
                  "도안",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey, // 테두리 색상
                    ),
                  ),
                  child: CustomTextField(),
                ),
                SizedBox(height: 16),

                Text(
                  "작가",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey, // 테두리 색상
                    ),
                  ),
                  child: CustomTextField(),
                ),
                SizedBox(height: 16),

                Text(
                  "사이즈",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey, // 테두리 색상
                    ),
                  ),
                  child: CustomTextField(),
                ),
                SizedBox(height: 16),

                Text(
                  "실",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey, // 테두리 색상
                    ),
                  ),
                  child: CustomTextField(

                  ),
                ),
                SizedBox(height: 16),
                Row(
                   children: [
                     SizedBox(
                       width: 80,
                       child: Text("실 사용량"),
                     ),
                     Expanded(
                       child: Container(
                         height: 44,
                         padding: const EdgeInsets.symmetric(horizontal: 8),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(8),
                           border: Border.all(
                             color: Colors.grey, // 테두리 색상
                           ),
                         ),
                         child: CustomTextField(),
                       ),
                     ),
                   ],
                 ),
                 SizedBox(height: 16,),
                 Row(
                   children: [
                     SizedBox(
                       width: 80,
                       child: Text("게이지"),
                     ),
                     Expanded(
                       child: Container(
                         height: 44,
                         padding: const EdgeInsets.symmetric(horizontal: 8),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(8),
                           border: Border.all(
                             color: Colors.grey, // 테두리 색상
                           ),
                         ),
                         child: CustomTextField(),
                       ),
                     ),
                   ],
                 ),
                 SizedBox(height: 16,),

                Text(
                  "바늘",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey, // 테두리 색상
                    ),
                  ),
                  child: CustomTextField(

                  ),
                ),

                SizedBox(height: 40,),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: TextButton(
                    onPressed: () {
                      addWorkViewModel.onSavePressed(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "작품 추가하기",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}