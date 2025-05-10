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
                          CustomTextField(
                            hintText: "작품이름",
                            onSaved: (String? val) {
                              addWorkViewModel.nickname = val;
                            },
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () => addWorkViewModel.pickGoalDate(context),
                            style: TextButton.styleFrom(
                              //padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: PRIMARY_COLOR),
                              ),
                              foregroundColor: PRIMARY_COLOR, // 텍스트 색상
                              backgroundColor: Colors.transparent, // 배경 투명
                            ),
                            child: Text(addWorkViewModel.goalDate ?? "목표 날짜"),
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
                // SizedBox(height: 20,),
                // CustomTextField(label: "도안",),
                // SizedBox(height: 16,),
                // CustomTextField(label: "작가",),
                SizedBox(height: 16,),
                // CustomTextField(label: "사이즈",),
                // SizedBox(height: 16,),
                CustomTextField(
                  label: "실",
                  onSaved: (String? val) {
                    addWorkViewModel.customYarnInfo = val;
                  },
                ),
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
                CustomTextField(
                  label: "바늘",
                  onSaved: (String? val) {
                    addWorkViewModel.customNeedleInfo = val;
                  },
                ),
                SizedBox(height: 40,),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: TextButton(
                    onPressed: () { },
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