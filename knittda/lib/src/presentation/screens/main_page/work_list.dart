import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/data/repositories/design_repositories.dart';
import 'package:knittda/src/data/repositories/records_repository.dart';
import 'package:knittda/src/domain/use_case/create_record_use_case.dart';
import 'package:knittda/src/presentation/screens/add_work_page/search_patterns.dart';
import 'package:knittda/src/presentation/screens/work_detail/add_diary.dart';
import 'package:knittda/src/presentation/screens/work_detail/work_details.dart';
import 'package:knittda/src/presentation/view_models/record_view_model.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';
import 'package:knittda/src/presentation/view_models/search_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_view_model.dart';
import 'package:knittda/src/presentation/widgets/buttons/work_state_button.dart';
import 'package:knittda/src/presentation/widgets/listitems/work_list_item.dart';
import 'package:provider/provider.dart';
import '../../view_models/add_work_view_model.dart';

class WorkList extends StatefulWidget {
  const WorkList({super.key});

  @override
  _WorkListState createState() => _WorkListState();
}

class _WorkListState extends State<WorkList> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final workViewModel = context.read<WorkViewModel>();
      if (workViewModel.isReady && workViewModel.works.isEmpty) {
        workViewModel.getWorks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final workViewModel = context.watch<WorkViewModel>();

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
              child: workViewModel.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : workViewModel.works.isEmpty
                  ? Center(
                child: Text(
                  '작품이 없습니다.\n작품을 추가해주세요.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              )
                  : ListView.builder(
                itemCount: workViewModel.works.length,
                itemBuilder: (context, index) {
                  final work = workViewModel.works[index];
                  return WorkListItem(
                    work: work,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              WorkDetails(projectId: work.id!),
                        ),
                      );
                    },
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddDiary(work: work),
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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) =>
                      AddWorkViewModel(context.read<WorkViewModel>()),
                ),
                ChangeNotifierProvider(
                  create: (_) => SearchViewModel(DesignRepositories()),
                ),
              ],
              child: SearchPatterns(),
            ),
          ),
        );
      },
      backgroundColor: PRIMARY_COLOR,
      child: Icon(Icons.add, color: Colors.white),
      tooltip: '작품 추가',
    );
  }
}