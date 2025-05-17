import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/presentation/screens/add_work_page/add_work.dart';
import 'package:knittda/src/presentation/screens/work_detail/add_record.dart';
import 'package:knittda/src/presentation/screens/work_detail/show_work.dart';
import 'package:knittda/src/presentation/view_models/work_view_model.dart';
import 'package:knittda/src/presentation/widgets/buttons/work_state_button.dart';
import 'package:knittda/src/presentation/widgets/listitems/work_list_item.dart';
import 'package:provider/provider.dart';

class WorkList extends StatefulWidget {
  const WorkList({super.key});

  @override
  _WorkListState createState() => _WorkListState();
}

class _WorkListState extends State<WorkList> {

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
    final works = workVM.gotWorks;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: const Text(
            '나의\n작품',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const WorkStateButton(),
            const SizedBox(height: 20),
            Expanded(
              child: workVM.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : workVM.errorMessage != null
                  ? Center(child: Text('에러 발생: ${workVM.errorMessage}'))
                  : works == null || works.isEmpty
                  ? Center(
                child: Text(
                  '작품이 없습니다.\n작품을 추가해주세요.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              )
                  : ListView.builder(
                itemCount: works.length,
                itemBuilder: (context, index) {
                  final work = works[index];
                  return WorkListItem(
                    work: work,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ShowWork(projectId: work.id!),
                        ),
                      );
                    },
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AddRecord(work: work),
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
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AddWork()),
        );

        if (result == true) {
          _getWorks(); // ✅ 돌아왔을 때만 목록 다시 불러오기
        }
      },
      backgroundColor: PRIMARY_COLOR,
      child: Icon(Icons.add, color: Colors.white),
      tooltip: '작품 추가',
    );
  }
}