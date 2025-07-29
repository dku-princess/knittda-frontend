import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';
import 'package:knittda/src/domain/use_case/work_use_cases.dart';

import 'package:knittda/src/presentation/screens/add_work_page/add_work.dart';
import 'package:knittda/src/presentation/screens/work_detail/add_record.dart';
import 'package:knittda/src/presentation/screens/work_detail/report_ui.dart';
import 'package:knittda/src/presentation/screens/work_detail/show_work.dart';
import 'package:knittda/src/presentation/view_models/record_form_view_model.dart';
import 'package:knittda/src/presentation/view_models/record_list_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_detail_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_form_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_list_view_model.dart';
import 'package:knittda/src/presentation/widgets/buttons/work_state_button.dart';
import 'package:knittda/src/presentation/widgets/listitems/work_list_item.dart';
import 'package:provider/provider.dart';


class WorkList extends StatefulWidget {
  const WorkList({super.key});

  @override
  State<WorkList> createState() => _WorkListState();
}

class _WorkListState extends State<WorkList> {
  String _filterStatus = 'IN_PROGRESS';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getWorks());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getWorks() async {
    final workListVM = context.read<WorkListViewModel>();
    await workListVM.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final workListVM = context.watch<WorkListViewModel>();
    final works = workListVM.works;

    final filteredWorks = works.where((work) => work.status == _filterStatus).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 90,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: const Text(
            '나의\n뜨개 작품',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                WorkStateButton(
                  selectedStatus: _filterStatus,
                  onChanged: (newStatus) {
                    setState(() {
                      _filterStatus = newStatus;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: workListVM.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : workListVM.error != null
                      ? Center(child: Text('에러 발생: ${workListVM.error}'))
                      : filteredWorks.isEmpty
                      ? const Center(
                    child: Text(
                      '작품이 없습니다',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  )
                      : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: filteredWorks.length,
                    itemBuilder: (context, index) {
                      final work = filteredWorks[index];
                      return WorkListItem(
                        key: ValueKey(work.id),
                        work: work,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MultiProvider(
                                providers: [
                                  ChangeNotifierProvider(
                                    create: (_) => WorkDetailViewModel(context.read<WorkUseCases>())
                                      ..load(work.id!),                          // 작품 상세 선로드
                                  ),
                                  ChangeNotifierProvider(
                                    create: (_) => RecordListViewModel(context.read<RecordUseCases>())
                                      ..refresh(work.id!),                       // 기록 목록 선로드
                                  ),
                                ],
                                child: ShowWork(projectId: work.id!),
                              ),
                            ),
                          );
                        },

                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) => RecordFormViewModel(
                                  useCases: context.read<RecordUseCases>(),
                                  listViewModel: null,
                                  detailViewModel: null,
                                ),
                                child: AddRecord(work: work),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          if (DateTime.now().weekday == DateTime.sunday)
            Positioned(
              bottom: 16,
              left: 16,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ReportUi()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  //foregroundColor: PRIMARY_COLOR,
                  side: BorderSide(color: PRIMARY_COLOR),
                ),
                child: Text('주간 리포트 확인', style: TextStyle(color: PRIMARY_COLOR),),
              ),
            ),
        ],
      ),

      floatingActionButton: _addWorkFloatingButton(context),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _addWorkFloatingButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: PRIMARY_COLOR,
      tooltip: '작품 추가',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (context) => WorkFormViewModel(
                  useCases: context.read<WorkUseCases>(),
                  listViewModel: context.read<WorkListViewModel>(),
                  detailViewModel: null,
                ),
                child: const AddWork(),
              ),
            ),
          );
        },
      child: Icon(Icons.add, color: Colors.white)
    );
  }
}
