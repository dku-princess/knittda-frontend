import 'package:flutter/material.dart';
import 'package:knittda/src/core/constants/color.dart';
import 'package:knittda/src/data/repositories/record_repository.dart';
import 'package:knittda/src/domain/use_case/record_use_cases.dart';
import 'package:knittda/src/presentation/screens/work_detail/add_record.dart';
import 'package:knittda/src/presentation/screens/work_detail/diary.dart';
import 'package:knittda/src/presentation/screens/work_detail/edit_work.dart';
import 'package:knittda/src/presentation/screens/work_detail/info.dart';
import 'package:knittda/src/presentation/screens/work_detail/report.dart';
import 'package:knittda/src/presentation/view_models/record_view_model.dart';
import 'package:knittda/src/presentation/view_models/work_view_model.dart';
import 'package:knittda/src/presentation/widgets/buttons/work_status_button.dart';
import 'package:knittda/src/presentation/widgets/edit_delete_menu.dart';
import 'package:knittda/src/presentation/widgets/image_box.dart';
import 'package:provider/provider.dart';

class ShowWork extends StatefulWidget {
  final int projectId;
  final int initialTabIndex;

  const ShowWork({
    super.key,
    required this.projectId,
    this.initialTabIndex = 0,
  });

  @override
  State<ShowWork> createState() => _ShowWorkState();
}

class _ShowWorkState extends State<ShowWork> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  bool _isLoading = true;

  final List<Tab> tabs = <Tab>[
    Tab(text:'정보'),
    Tab(text:'다이어리'),
    Tab(text:'리포트'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    )..addListener(() => setState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getWorkAndRecords();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _getWorkAndRecords() async {
    try {
      final workViewModel = context.read<WorkViewModel>();
      final recordViewModel = context.read<RecordViewModel>();

      await workViewModel.getWork(widget.projectId);
      await recordViewModel.getRecords(widget.projectId);
    } catch (e) {
      debugPrint('작품 불러오기 오류: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('작품 정보를 불러오는 데 실패했습니다.')),
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
    final viewModel = context.watch<WorkViewModel>();
    final work = viewModel.work;
    final error = viewModel.error;
    final isBusy = viewModel.isLoading;
    final topPadding = MediaQuery.of(context).padding.top; //상태바 높이

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('에러 발생: ${viewModel.error}')),
      );
    }

    if (work == null) {
      return const Scaffold(
        body: Center(child: Text('작품을 불러올 수 없습니다.')),
      );
    }

    return Stack(
      children: [
        DefaultTabController(
          length: tabs.length,
          child: Scaffold(
            floatingActionButton: _tabController.index == 1
                ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddRecord(work: work)
                  ),
                );
              },
              backgroundColor: PRIMARY_COLOR,
              child: const Icon(Icons.add, color: Colors.white),
            )
                : null,

            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true, //appbar 고정
                    expandedHeight: 210.0, //확장 높이
                    //backgroundColor: Colors.white, //배경 흰색
                    leading: IconButton( //뒤로가기 버튼
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    actions: [
                      EditDeleteMenu(
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>  EditWork(work: work),
                            ),
                          );
                        },

                        onDelete: () async {
                          final success = await viewModel.deleteWork(work.id!);

                          if (!context.mounted) return;

                          if (success) {
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error ?? '삭제 중 오류가 발생했습니다')),
                            );
                          }
                        },
                        deleteDialogTitle: '작품 삭제',
                        deleteDialogContent: '정말 이 작품을 삭제하시겠습니까?',
                      )
                    ],

                    flexibleSpace: FlexibleSpaceBar( //확장영역
                      background: Padding(
                        padding: EdgeInsets.only(top: topPadding + 56, left: 24),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageBox(
                              networkImageUrl: work.thumbnailUrl,
                              height: 100,
                              width: 100,
                            ),
                            SizedBox(width: 26),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  work.nickname,
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 10),
                                WorkStatusButton(
                                  work: work,
                                  updateWork: viewModel.updateWork,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: tabs,
                      indicatorColor: Colors.black87, //tabbar 밑줄 색상
                      labelColor: Colors.black87, //선택된 영역 글자 색
                      unselectedLabelColor: Colors.grey, //선택 안된 영역 글자색
                    ),
                  ),
                ];
              },
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  Info(work:work),
                  Diary(),
                  Report(work:work),
                ],
              ),
            ),
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