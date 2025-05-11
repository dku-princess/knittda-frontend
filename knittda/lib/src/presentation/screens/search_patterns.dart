import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/view_models/add_work_view_model.dart';

import 'package:knittda/src/presentation/widgets/form/custom_text_field.dart';
import 'package:knittda/src/presentation/screens/add_work.dart';
import 'package:provider/provider.dart';

class SearchPatterns extends StatelessWidget {
  const SearchPatterns({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드 올라와도 body 크기 유지
      appBar: AppBar(
        title: const Text('도안 검색', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            CustomTextField(hintText: "검색"),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '도안을 선택하여 작품 정보 불러오기',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '도안이 없으면\n작품 정보를 직접 입력할 수도 있어요',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[800], fontSize: 14),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 130,
                      height: 44,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider.value(
                                value: context.read<AddWorkViewModel>(), // 현재 생성된 인스턴스 전달
                                child: AddWorkPage(),
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFE9F9F5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "직접 입력하기",
                          style: TextStyle(
                            color: Color(0xFF00A367),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}