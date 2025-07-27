import 'package:flutter/material.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';
import 'package:knittda/src/domain/use_case/work_use_cases.dart';
import 'package:knittda/src/presentation/screens/work_detail/show_work.dart';
import 'package:knittda/src/presentation/view_models/record_list_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_detail_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_preview_view_model.dart';
import 'package:knittda/src/presentation/widgets/listitems/work_preview_list_item.dart';
import 'package:provider/provider.dart';

class Work extends StatefulWidget {
  const Work({super.key});

  @override
  State<Work> createState() => _WorkState();
}

class _WorkState extends State<Work> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WorkPreviewViewModel>().load();
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            '작품',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      body: Consumer<WorkPreviewViewModel>(
        builder: (context, vm, _) {
          // 1) 로딩 & 데이터 없음
          if (vm.isLoading && vm.previews.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2) 오류 & 데이터 없음
          if (vm.error != null && vm.previews.isEmpty) {
            return RefreshIndicator(
              onRefresh: vm.refresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 120),
                  Center(child: Text(vm.error!)),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: vm.refresh,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  controller: _scroll,
                  padding: const EdgeInsets.only(top: 20, bottom: 20, left: 24, right: 24),
                  physics: const AlwaysScrollableScrollPhysics(),

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.82,
                  ),

                  itemCount: vm.previews.length,
                  itemBuilder: (context, index) {
                    final preview = vm.previews[index];
                    return WorkPreviewListItem(
                      workPreview: preview,
                      onTap: () {
                        final workVM = WorkDetailViewModel(
                            context.read<WorkUseCases>())
                          ..load(preview.projectId);
                        final recordVM = RecordListViewModel(
                            context.read<RecordUseCases>())
                          ..refresh(preview.projectId);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                              MultiProvider(
                                providers: [
                                  ChangeNotifierProvider.value(value: workVM),
                                  ChangeNotifierProvider.value(value: recordVM),
                                ],
                                child: ShowWork(projectId: preview.projectId),
                              ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}