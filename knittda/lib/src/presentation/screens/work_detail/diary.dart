import 'package:flutter/material.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';
import 'package:knittda/src/presentation/screens/work_detail/show_record.dart';
import 'package:knittda/src/presentation/view_models/record_detail_view_model.dart';
import 'package:knittda/src/presentation/view_models/record_list_view_model.dart';
import 'package:knittda/src/presentation/widgets/listitems/record_list_item.dart';
import 'package:provider/provider.dart';

class Diary extends StatelessWidget {
  final bool isOwner;
  const Diary({super.key, required this.isOwner});

  @override
  Widget build(BuildContext context) {
    final recordListViewModel = context.watch<RecordListViewModel>();
    final records = recordListViewModel.records;

    if (recordListViewModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (recordListViewModel.error != null) {
      return Center(child: Text('에러 발생: ${recordListViewModel.error}'));
    }

    if (records.isEmpty) {
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
              final recordListVM = context.read<RecordListViewModel>();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiProvider(
                    providers: [
                      // 이미 존재하는 리스트 VM 전달
                      ChangeNotifierProvider.value(value: recordListVM),

                      // 상세 VM은 새로 생성
                      ChangeNotifierProvider(
                        create: (_) => RecordDetailViewModel(
                          context.read<RecordUseCases>(),
                        )..load(record.id!),
                      ),
                    ],
                    child: ShowRecord(
                      recordId: record.id!,
                      isOwner : isOwner,
                    ),
                  ),
                ),
              );
            }
          );
        },
      ),
    );
  }
}