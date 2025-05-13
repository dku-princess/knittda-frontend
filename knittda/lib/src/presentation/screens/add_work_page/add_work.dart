import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/design_model.dart';
import 'package:knittda/src/presentation/view_models/add_work_view_model.dart';
import 'package:provider/provider.dart';
import 'package:knittda/src/core/constants/color.dart';

class AddWorkPage extends StatelessWidget {
  final DesignModel? design;
  const AddWorkPage({super.key, this.design});

  @override
  Widget build(BuildContext context) {
    final addWorkViewModel = context.watch<AddWorkViewModel>();

    // design이 주어졌고 아직 초기화되지 않았을 때
    if (design != null &&
        (addWorkViewModel.design == null || addWorkViewModel.design!.id != design!.id)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.microtask(() {
          addWorkViewModel.setDesign(design!);
        });
      });
    }

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
                          TextFormField(
                             controller: addWorkViewModel.nicknameController,
                             validator: (val) => addWorkViewModel.nicknameValidator(val),
                             decoration: InputDecoration(
                               isDense: true,
                               hintText: "작품이름",
                               contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(8),
                                 borderSide: const BorderSide(color: Colors.grey),
                               ),
                               focusedBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(8),
                                 borderSide: const BorderSide(color: Colors.blue),
                               ),
                               errorBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(8),
                                 borderSide: const BorderSide(color: Colors.red),
                               ),
                               focusedErrorBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(8),
                                 borderSide: const BorderSide(color: Colors.red),
                               ),
                               errorStyle: const TextStyle(height: 0, fontSize: 0), // 숨기기
                             ),
                             style: const TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 10),
                          FormField<String>(
                            initialValue: addWorkViewModel.goalDate,
                            validator: addWorkViewModel.goalDateValidator,
                            builder: (FormFieldState<String> field) {
                              final hasError = field.hasError;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      await addWorkViewModel.pickGoalDate(context);
                                      field.didChange(addWorkViewModel.goalDate); // 선택 후 상태 갱신
                                    },
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                          color: hasError ? Colors.red : PRIMARY_COLOR, // ✅ 테두리 색
                                        ),
                                      ),
                                      foregroundColor: hasError ? Colors.red : PRIMARY_COLOR, // ✅ 텍스트 색
                                    ),
                                    child: Text(addWorkViewModel.goalDate ?? "목표 날짜"),
                                  ),
                                  // if (hasError)
                                  //   const SizedBox(height: 4), // 에러 메시지 숨기고 싶으면 지워도 됨
                                  // // if (hasError)
                                  // //   Text(
                                  // //     field.errorText ?? '',
                                  // //     style: const TextStyle(color: Colors.red, fontSize: 12),
                                  // //   ),
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
                TextField(
                  controller: addWorkViewModel.designController,
                  readOnly: addWorkViewModel.design != null,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: addWorkViewModel.design != null,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16),

                Text(
                  "작가",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: addWorkViewModel.designerController,
                  readOnly: addWorkViewModel.design != null,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: addWorkViewModel.design != null,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16),

                // Text(
                //   "사이즈",
                //   style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
                // ),
                // SizedBox(height: 10),
                // Container(
                //   height: 44,
                //   padding: const EdgeInsets.symmetric(horizontal: 8),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8),
                //     border: Border.all(
                //       color: Colors.grey, // 테두리 색상
                //     ),
                //   ),
                //   child: CustomTextField(),
                // ),
                // SizedBox(height: 16),

                Text(
                  "실",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: addWorkViewModel.yarnController,
                  validator: (val) => addWorkViewModel.yarnValidator(val),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    errorStyle: const TextStyle(height: 0, fontSize: 0),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16),
                // Row(
                //    children: [
                //      SizedBox(
                //        width: 80,
                //        child: Text("실 사용량"),
                //      ),
                //      Expanded(
                //        child: Container(
                //          height: 44,
                //          padding: const EdgeInsets.symmetric(horizontal: 8),
                //          decoration: BoxDecoration(
                //            borderRadius: BorderRadius.circular(8),
                //            border: Border.all(
                //              color: Colors.grey, // 테두리 색상
                //            ),
                //          ),
                //          child: CustomTextField(),
                //        ),
                //      ),
                //    ],
                //  ),
                //  SizedBox(height: 16,),
                //  Row(
                //    children: [
                //      SizedBox(
                //        width: 80,
                //        child: Text("게이지"),
                //      ),
                //      Expanded(
                //        child: Container(
                //          height: 44,
                //          padding: const EdgeInsets.symmetric(horizontal: 8),
                //          decoration: BoxDecoration(
                //            borderRadius: BorderRadius.circular(8),
                //            border: Border.all(
                //              color: Colors.grey, // 테두리 색상
                //            ),
                //          ),
                //          child: CustomTextField(),
                //        ),
                //      ),
                //    ],
                //  ),
                //  SizedBox(height: 16,),

                Text(
                  "바늘",
                  style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Pretendard', fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: addWorkViewModel.needleController,
                  validator: (val) => addWorkViewModel.needleValidator(val),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    errorStyle: const TextStyle(height: 0, fontSize: 0),
                  ),
                  style: const TextStyle(fontSize: 14),
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