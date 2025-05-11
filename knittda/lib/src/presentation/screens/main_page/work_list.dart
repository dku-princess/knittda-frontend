import 'package:flutter/material.dart';
import 'package:knittda/src/presentation/screens/add_work_page/search_patterns.dart';
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
    final workViewModel = context.read<WorkViewModel>();
    if (workViewModel.isReady && workViewModel.works.isEmpty) {
      workViewModel.getWorks();
    }
  }

  @override
  Widget build(BuildContext context) {
    final workViewModel = context.watch<WorkViewModel>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            '나의\n작품',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            WorkStateButton(),
            SizedBox(height: 20),
            Expanded(
              child: workViewModel.works.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: workViewModel.works.length + 1,
                itemBuilder: (context, index) {
                  if (index < workViewModel.works.length) {
                    final work = workViewModel.works[index];
                    return WorkListItem(work: work);
                  } else {
                    return _addWorkButton(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addWorkButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: SizedBox(
        width: double.infinity,
        height: 36,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider(
                    create: (_) => AddWorkViewModel(context.read<WorkViewModel>()),
                    child: SearchPatterns(),
                  )
              ),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.zero,
          ),
          child: Icon(Icons.add, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}
