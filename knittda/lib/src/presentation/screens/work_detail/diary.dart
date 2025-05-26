import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/screens/work_detail/show_record.dart';
import 'package:knittda/src/presentation/view_models/record_view_model.dart';
import 'package:knittda/src/presentation/widgets/listitems/record_list_item.dart';
import 'package:provider/provider.dart';

class Diary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recordVM = context.watch<RecordViewModel>();
    final records = recordVM.gotRecords;

    if (recordVM.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (recordVM.errorMessage != null) {
      return Center(child: Text('에러 발생: ${recordVM.errorMessage}'));
    }

    if (records == null || records.isEmpty) {
      return Center(child: Text('기록이 없습니다.'));
    }

    return Padding(
      padding: EdgeInsets.all(26.0),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[index];
          return RecordListItem(
            record: record,
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShowRecord(recordId: record.id!)),
              );
            }
          );
        },
      ),
    );
  }
}