import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/record_model.dart';
import 'package:knittda/src/presentation/screens/work_detail/show_record.dart';
import 'package:knittda/src/presentation/widgets/listitems/record_list_item.dart';

class Diary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final record1 = RecordModel.forCreate(
      projectId   : 0,
      recordStatus: " ",
      tags        : ["뿌듯해요", "재미있어요", "너무 지루해요", "힘들어요", "지쳐요"],
      comment     : "testsldkfjlsdkjflskdjflsdjflksdjlfjkskdljfsdlkjflskdjf;dj;akdj;lsjfdalfjslaifj;dlasijf;iasdjf;isjdaf;lasij;flisdja;fijds;afjsdfji;sajdij;asfjisd;afj;sia",
      recordedAt  : DateTime.now(),
      files       : [],
    );
    final record2 = RecordModel.forCreate(
      projectId   : 0,
      recordStatus: " ",
      tags        : ["뿌듯해요", "재미있어요", "너무 지루해요", "힘들어요", "지쳐요"],
      comment     : "testsldkfjlsdkjflskdjflsdjflksdjlfjkskdljfsdlkjflskdjf;dj;akdj;lsjfdalfjslaifj;dlasijf;iasdjf;isjdaf;lasij;flisdja;fijds;afjsdfji;sajdij;asfjisd;afj;sia",
      recordedAt  : DateTime.now(),
      files       : [],
    );

    final List<RecordModel> recordlist = <RecordModel> [record1, record2];

    return Padding(
      padding: EdgeInsets.all(26.0),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: recordlist.length,
        itemBuilder: (context, index) {
          return RecordListItem(
            record: recordlist[index],
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShowRecord(record: recordlist[index],)),
              );
            }
          );
        },
      ),
    );
  }
}