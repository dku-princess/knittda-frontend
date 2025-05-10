import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatelessWidget {
  final String? label;// 텍스트 필드 제목
  final String hintText;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    this.label,
    required this.hintText,

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
          SizedBox(height: 8),
        ],
        TextFormField(
          style: const TextStyle(fontSize: 14),

          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none, // 테두리 삭제
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