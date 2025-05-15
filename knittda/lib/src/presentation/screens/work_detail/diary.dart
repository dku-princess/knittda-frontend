import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/widgets/listitems/diary_list_item.dart';

class Diary extends StatelessWidget {
  final List<Widget> diarylist = <Widget> [
    DiaryListItem(
        recordedAt: DateTime.now(),
        images: [],
        comment: "testsldkfjlsdkjflskdjflsdjflksdjlfjkskdljfsdlkjflskdjf;dj;akdj;lsjfdalfjslaifj;dlasijf;iasdjf;isjdaf;lasij;flisdja;fijds;afjsdfji;sajdij;asfjisd;afj;sia",
        tags: ["뿌듯해요", "재미있어요", "너무 지루해요", "힘들어요", "지쳐요"]
    ),
    DiaryListItem(
        recordedAt: DateTime.now(),
        images: [],
        comment: "testsldkfjlsdkjflskdjflsdjflksdjlfjkskdljfsdlkjflskdjf;dj;akdj;lsjfdalfjslaifj;dlasijf;iasdjf;isjdaf;lasij;flisdja;fijds;afjsdfji;sajdij;asfjisd;afj;sia",
        tags: ["뿌듯해요", "재미있어요", "너무 지루해요", "힘들어요", "지쳐요"]
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: diarylist.length,
      itemBuilder: (context, index) {
        return diarylist[index];
      },
    );
  }
}