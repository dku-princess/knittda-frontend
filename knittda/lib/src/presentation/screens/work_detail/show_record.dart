import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:knittda/src/domain/use_case/update_record_use_case.dart';
import 'package:knittda/src/presentation/screens/work_detail/edit_record.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';
import 'package:knittda/src/presentation/view_models/edit_record_view_model.dart';
import 'package:knittda/src/presentation/view_models/record_view_model.dart';
import 'package:knittda/src/presentation/widgets/edit_delete_menu.dart';
import 'package:provider/provider.dart';

class ShowRecord extends StatefulWidget {
  final int recordId;

  const ShowRecord({super.key, required this.recordId});

  @override
  State<ShowRecord> createState() => _ShowRecordState();
}

class _ShowRecordState extends State<ShowRecord> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchRecord();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchRecord() async {
    try {
      final recordVM = context.read<RecordViewModel>();

      recordVM.reset();
      await recordVM.getRecord(widget.recordId);
    } catch (e) {
      debugPrint('기록 불러오기 오류: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('기록 정보를 불러오는 데 실패했습니다.')),
      );
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final recordVM = context.watch<RecordViewModel>();
    final record = recordVM.gotRecord;
    final error = recordVM.errorMessage;
    final isBusy = recordVM.isLoading;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('에러 발생: ${recordVM.errorMessage}')),
      );
    }

    if (record == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('기록을 불러올 수 없습니다.')),
      );
    }

    final height = MediaQuery.of(context).size.height / 3; //화면의 1/3
    final dateStr = DateUtilsHelper.toDotFormat(record.createdAt!);
    final timeStr = DateUtilsHelper.toHourMinuteFormat(record.createdAt!);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            actions: [
              EditDeleteMenu(
                onEdit: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider(
                        create: (_) => EditRecordViewModel(
                          authViewModel: context.read<AuthViewModel>(),
                          updateRecordUseCase: UpdateRecordUseCase(
                            recordsRepository: context.read<RecordsRepository>(),
                          ),
                        ),
                        child: EditRecord(record: record),
                      ),
                    ),
                  );

                  if (result == true && mounted) {
                    await context.read<RecordViewModel>().getRecord(widget.recordId);
                  }
                },
                onDelete: () async {
                  final success = await recordVM.deleteRecord(record.id!);

                  if (!context.mounted) return;

                  if (success) {
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error ?? '삭제 중 오류가 발생했습니다')),
                    );
                  }
                },
              )
            ],
          ),
          body: ListView(
            children: [
              //이미지
              if (record.images != null && record.images!.isNotEmpty) ...[
                SizedBox(
                  height: height,
                  child: record.images!.length == 1
                      ? Image.network(
                    record.images!.first.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                      : PageView.builder(
                    itemCount: record.images!.length,
                    padEnds: false, // 첫 이미지 왼쪽 여백 제거
                    controller: PageController(),
                    itemBuilder: (context, index) {
                      final image = record.images![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Image.network(
                          image.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //시간
                    Row(
                      children: [
                        Text(dateStr, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        SizedBox(width: 10,),
                        Text(timeStr, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 26),

                    //comment
                    if (record.comment != null && record.comment!.isNotEmpty) ...[
                      Text(
                        record.comment ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 40),
                    ],

                    // 태그
                    if (record.tags != null && record.tags!.isNotEmpty) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: record.tags!.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                border: Border.all(color: PRIMARY_COLOR),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  color: PRIMARY_COLOR,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isBusy)
          const ColoredBox(
            color: Colors.black26,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}