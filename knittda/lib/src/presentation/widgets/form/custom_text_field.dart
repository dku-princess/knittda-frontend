import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatelessWidget {
  final String? hintText;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final bool readOnly;

  const CustomTextField({
    this.hintText,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.controller,
    this.onSaved,
    this.validator,
    this.onSubmitted,
    this.textInputAction,
    this.readOnly = false,

    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          isDense: true,
          border: InputBorder.none,
        ),
        maxLines: maxLines,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onFieldSubmitted: onSubmitted,
        controller: controller,
        onSaved: onSaved,
        validator: validator,
        textInputAction: textInputAction,
        readOnly: readOnly
      ),
    );
  }
}