import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatelessWidget {
  final String? label;// 텍스트 필드 제목
  final String? hintText;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    this.label,
    this.hintText,

    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.controller,
    this.onSaved,
    this.validator,


    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && label!.isNotEmpty) ...[
          Text( label!,
              style: TextStyle(fontSize: 16)
          ),
          SizedBox(height: 10),
        ],
        TextFormField(
          style: const TextStyle(fontSize: 14),

          decoration: InputDecoration(
            hintText: hintText,
            isDense: true,
            filled: true,
            fillColor: Colors.grey[200],
            border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // ← 여기!
            borderSide: BorderSide.none, // 테두리 없애고 배경만 보이게
            ),
          ),

          maxLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,

          controller: controller, //텍스트 컨트롤러
          onSaved: onSaved, // 폼 저장시 실행할 함수
          validator: validator, //폼 검증시 실행할 함수
        ),
      ],
    );
  }
}