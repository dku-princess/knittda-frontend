import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressSection extends StatelessWidget {
  final ValueChanged onProgressChanged;
  const ProgressSection({super.key, required this.onProgressChanged});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
      onProgressChanged;
    }, child: Text('뜨고있어요'));
  }
}
