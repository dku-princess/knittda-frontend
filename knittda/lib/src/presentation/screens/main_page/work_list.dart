import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:knittda/src/domain/use_case/create_record_use_case.dart';
import 'package:knittda/src/domain/use_case/create_work_use_case.dart';
import 'package:knittda/src/presentation/screens/add_work_page/add_work.dart';
import 'package:knittda/src/presentation/screens/work_detail/add_record.dart';
import 'package:knittda/src/presentation/screens/work_detail/show_work.dart';
import 'package:knittda/src/presentation/view_models/add_record_view_model.dart';
import 'package:knittda/src/presentation/view_models/add_work_view_model.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_view_model.dart';
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
    try {
      final workVM = context.read<WorkViewModel>();
      await workVM.getWorks();
    } catch (e) {
      debugPrint('작품 불러오기 오류: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('작품을 불러오는 데 실패했습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final workVM = context.watch<WorkViewModel>();
    final works = workVM.works;

    final filteredWorks = (works ?? []).where((work) => work.status == _filterStatus).toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: const Text(
            '나의\n뜨개 작품',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      body: Padding(
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
              child: workVM.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : workVM.errorMessage != null
                  ? Center(child: Text('에러 발생: ${workVM.errorMessage}'))
                  : filteredWorks.isEmpty
                  ? const Center(
                child: Text(
                  '작품이 없습니다.\n작품을 추가해주세요.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              )
                  : ListView.builder(
                itemCount: filteredWorks.length,
                itemBuilder: (context, index) {
                  final work = filteredWorks[index];
                  return WorkListItem(
                    work: work,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ShowWork(projectId: work.id!),
                        ),
                      );
                    },
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                            create: (_) => AddRecordViewModel(
                              authViewModel: context.read<AuthViewModel>(),
                              createRecordUseCase: CreateRecordUseCase(
                                recordsRepository: context.read<RecordsRepository>(),
                              ),
                              recordsRepository: context.read<RecordsRepository>(),
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
      floatingActionButton: _addWorkFloatingButton(context),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _addWorkFloatingButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: PRIMARY_COLOR,
      tooltip: '작품 추가',
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<AddWorkViewModel>(
              create: (_) => AddWorkViewModel(
                authViewModel: context.read<AuthViewModel>(),
                createWorkUseCase: CreateWorkUseCase(
                  workRepository: context.read<WorkRepository>(),
                ),
                workRepository: context.read<WorkRepository>(),
              ),
              child: AddWork(),
            ),
          ),
        );

      },
      child: Icon(Icons.add, color: Colors.white)
    );
  }
}